class SubTypePayment < ApplicationRecord
  acts_as_paranoid

  belongs_to :type_of_payment
  has_many :budgets

  has_paper_trail

  validates :name, presence: true
end
