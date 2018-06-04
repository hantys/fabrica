class Budget < ApplicationRecord
  enum delivery_options: { store_delivery: 0, withdrawal_in_hands: 1 }
  enum type_of_payment: { bank_slip: 0, credit_card: 1, in_cash: 2, check: 3, debit: 4, transfer: 5, deposit: 6 }

  belongs_to :client
  belongs_to :employee
  has_many :budget_products, dependent: :destroy

  accepts_nested_attributes_for :budget_products, allow_destroy: true

  validates :value, presence: true
  validates :deadline, presence: true
  validates :name, presence: true

  after_save :set_value

  private
    def set_value
      unless self.value.round(2) == self.budget_products.sum(:total_value).round(2)
        self.update value: self.budget_products.sum(:total_value)
      end
    end
end
