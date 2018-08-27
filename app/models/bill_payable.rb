class BillPayable < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader


  belongs_to :provider_contract, -> { with_deleted }
  belongs_to :category, -> { with_deleted }, optional: true
  belongs_to :revenue, -> { with_deleted }, optional: true

  has_many :bill_payable_installments, dependent: :destroy

  accepts_nested_attributes_for :bill_payable_installments, allow_destroy: true

  has_paper_trail

  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true
  validates :bill_payable_installments, presence: true

  before_create :verify_total
  before_update :set_partial_value
  after_update :set_value
  after_create :set_value_create

  def verify_total
    value_item = self.bill_payable_installments.sum(:value).round(2)
    puts "***************************************"
    puts value_item
    puts (provider_contract.total_value - provider_contract.partil_value)
    puts value_item > (provider_contract.total_value - provider_contract.partil_value)
    provider_contract = ProviderContract.find self.provider_contract_id
    if value_item > (provider_contract.total_value - provider_contract.partil_value)
      errors.add :total_value, "Não pode ser menos que a soma das parcelas."
      false
      # Rails 5
      throw(:abort)
    end
  end

  def set_partial_value
    provider_contract = self.provider_contract
    ActiveRecord::Base.transaction do
      provider_contract.update partil_value: (provider_contract.partil_value - self.total_value.round(2))
    end
  end

  def set_value
    total_bill = self.total_value.round(2)
    value_item = self.bill_payable_installments.sum(:value).round(2)
      ActiveRecord::Base.transaction do
        unless total_bill == value_item
          self.update total_value: value_item
        end
        provider_contract = self.provider_contract
        provider_contract.update partil_value: (provider_contract.partil_value + value_item)
      end
  end

  def set_value_create
    total_bill = self.total_value.round(2)
    value_item = self.bill_payable_installments.sum(:value).round(2)
    ActiveRecord::Base.transaction do
      self.update total_value: value_item
      provider_contract = self.provider_contract
      provider_contract.update partil_value: ((provider_contract.partil_value) + value_item)
    end
  end

end
