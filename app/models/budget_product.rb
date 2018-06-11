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

  def value_discount_total
    total_value - total_value_with_discount
  end

  private
    def set_total_value
      self.unit_value = Product.find(self.product_id).price.round(2)
      self.total_value = (self.unit_value * self.qnt).round(2)

      if self.discount.to_f > 0
        if self.discount_type
          self.total_value_with_discount = (((self.unit_value.to_f.round(2) * self.discount.to_f.round(2)) / 100) * self.qnt.to_f).round(2)
        else
          self.total_value_with_discount = (self.discount.to_f.round(2) * self.qnt.to_f).round(2)
        end
      else
        self.total_value_with_discount = 0
      end
    end
end