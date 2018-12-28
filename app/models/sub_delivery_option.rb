class SubDeliveryOption < ApplicationRecord
  acts_as_paranoid

  belongs_to :delivery_option
  has_many :budgets

  has_paper_trail

  validates :name, presence: true
end
