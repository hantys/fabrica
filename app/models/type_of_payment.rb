class TypeOfPayment < ApplicationRecord
  validates :name, presence: true
  has_many :budgets
end
