class TypeOfPayment < ApplicationRecord
  validates :name, presence: true
  has_many :budgets

  has_paper_trail
end
