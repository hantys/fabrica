class BudgetProduct < ApplicationRecord
  belongs_to :budget
  belongs_to :product

  validates :unit_value, presence: true
  validates :total_value, presence: true
  validates :qnt, presence: true
  validates :unit_value, numericality: { greater_than: 0 }
  validates :total_value, numericality: { greater_than: 0 }
  validates :qnt, numericality: { greater_than: 0 }


  before_save :set_total_value

  private
    def set_total_value
      self.unit_value = Product.find(self.product_id).price
      self.total_value = self.unit_value * self.qnt

      if self.discount.to_f > 0
        if self.discount_type
          self.total_value_with_discount = ((self.unit_value.to_f * self.discount.to_f) / 100) * self.qnt.to_f
        else
          self.total_value_with_discount = self.discount.to_f * self.qnt.to_f
        end
      else
        self.total_value_with_discount = 0
      end
    end
end