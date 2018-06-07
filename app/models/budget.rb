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

  validates :value, numericality: { greater_than: 0 }

  after_save :set_value

  private
    def set_value
      unless self.value.round(2) == self.budget_products.sum(:total_value).round(2)
        self.update value: self.budget_products.sum(:total_value)
      end
      descount_total = self.budget_products.sum(:total_value_with_discount)
      if descount_total != self.discount_items
        if descount_total.to_f > 0
          self.update discount_items: descount_total.to_f, value_with_discount: (self.value - descount_total.to_f)
        else
          if self.discount.to_f > 0
            if self.discount_type
              self.update discount_items: 0, value_with_discount: (self.value.to_f - ((self.value * self.discount.to_f) / 100))
            else
              self.update discount_items: 0, value_with_discount: (self.value.to_f - self.discount.to_f)
            end
          end
        end
      end
    end
end
