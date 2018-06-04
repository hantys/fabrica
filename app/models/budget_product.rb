class BudgetProduct < ApplicationRecord
  belongs_to :budget
  belongs_to :budget_item

  validates :unit_value, presence: true
  validates :total_value, presence: true
  validates :qnt, presence: true

  before_save :set_total_value

  private
    def set_total_value
      self.unit_value = BudgetItem.find(self.budget_item_id).price
      self.total_value = self.unit_value * self.qnt
    end
end
