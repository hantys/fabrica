class BudgetItem < ApplicationRecord
  belongs_to :composition, optional: true
end
