# frozen_string_literal: true

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

  validate :verify_total, only: :create
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
    bill_payable_installments.map do |e|
      if e.status == 'pending'
        data << e.date
        check = false
      end
    end
    if data.present?
      self.due_date = data.min
      self.status = if due_date < Date.today
                      1
                    else
                      0
                    end
    else
      self.status = 2 if check
    end
  end

  def set_due_date_and_status
    data = []
    bill_payable_installments.map { |e| data << e.date }
    self.due_date = data.min
    self.status = if due_date < Date.today
                    1
                  else
                    0
                  end
  end

  private

  def check_destroy
    ActiveRecord::Base.transaction do
      provider_contract.update partil_value: (provider_contract.partil_value - total_value.round(2))
    end
  rescue Exception => e
    errors.add :base, 'Não pode ser apagado. Ocorreu algum problema'
    false
    # Rails 5
    throw(:abort)
  end

  def verify_total
    value_item = 0
    bill_payable_installments.map { |e| value_item += e.value }
    if value_item > (provider_contract.total_value - provider_contract.partil_value)
      # if value_item > (provider_contract.partil_value)
      errors.add :total_value, 'Não pode ser menos que a soma das parcelas.'
      false
      # Rails 5
      throw(:abort)
    end
  end

  def set_partial_value
    provider_contract = self.provider_contract
    ActiveRecord::Base.transaction do
      provider_contract.update partil_value: (provider_contract.partil_value - total_value.round(2))
    end
  end

  def set_value
    total_bill = total_value.round(2)
    value_item = bill_payable_installments.sum(:value).round(2)
    interest_item = bill_payable_installments.sum(:interest).round(2)
    ActiveRecord::Base.transaction do
      update total_value: value_item unless total_bill == value_item
      update interest: interest_item unless interest == interest_item

      provider_contract = self.provider_contract
      provider_contract.update partil_value: (provider_contract.partil_value + value_item)
    end
  end

  def set_value_create
    total_bill = total_value.round(2)
    value_item = bill_payable_installments.sum(:value).round(2)
    ActiveRecord::Base.transaction do
      update total_value: value_item
      provider_contract = self.provider_contract
      provider_contract.update partil_value: (provider_contract.partil_value + value_item)
    end
  end
end
