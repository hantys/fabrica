class TypeOfPayment < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  has_many :budgets

  has_paper_trail
end
