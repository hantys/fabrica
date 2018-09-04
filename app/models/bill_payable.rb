class BillPayable < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader

  enum status: { pending: 0, late: 1, paid: 2 }

  before_destroy :check_destroy

  belongs_to :provider_contract, -> { with_deleted }
  belongs_to :category, -> { with_deleted }, optional: true
  belongs_to :revenue, -> { with_deleted }, optional: true

  has_many :bill_payable_installments, dependent: :destroy

  accepts_nested_attributes_for :bill_payable_installments, allow_destroy: true

  has_paper_trail

  validate :verify_total
  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true
  validates :bill_payable_installments, presence: true

  before_create :set_due_date_and_status
  after_create :set_value_create

  before_update :set_partial_value
  before_update :due_date_verify
  after_update :set_value

  def due_date_verify
    data = []
    check = true
    self.bill_payable_installments.map do |e|
      if e.status == 'pending'
        data << e.date
        check = false
      end
    end
    if data.present?
      self.due_date = data.sort.first
      if self.due_date < Date.today
        self.status = 1
      else
        self.status = 0
      end
    else
      if check
        self.status = 2
      end
    end
  end

  def set_due_date_and_status
    data = []
    self.bill_payable_installments.map { |e| data << e.date }
    self.due_date = data.sort.first
    if self.due_date < Date.today
      self.status = 1
    else
      self.status = 0
    end
  end

  private
    def check_destroy
      begin
        ActiveRecord::Base.transaction do
          provider_contract.update partil_value: (provider_contract.partil_value - self.total_value.round(2))
        end
      rescue Exception => e
        errors.add :base, "Não pode ser apagado. Ocorreu algum problema"
        false
        # Rails 5
        throw(:abort)
      end
    end

    def verify_total
      value_item = 0
      self.bill_payable_installments.map { |e| value_item += e.value  }
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
      interest_item = self.bill_payable_installments.sum(:interest).round(2)
        ActiveRecord::Base.transaction do
          unless total_bill == value_item
            self.update total_value: value_item
          end
          unless self.interest == interest_item
            self.update interest: interest_item
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
