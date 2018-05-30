class BudgetProduct < ApplicationRecord
  belongs_to :budget
  belongs_to :budget_item
end
