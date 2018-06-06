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
    end
end
