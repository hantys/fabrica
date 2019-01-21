class TypeOfPayment < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  has_many :budgets
  has_many :sub_type_payments, dependent: :destroy

  accepts_nested_attributes_for :sub_type_payments, allow_destroy: true

  has_paper_trail
end
