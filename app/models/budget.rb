class Budget < ApplicationRecord
  belongs_to :client
  belongs_to :employee
  has_many :budget_products, dependent: :destroy

  accepts_nested_attributes_for :budget_products, allow_destroy: true
end
