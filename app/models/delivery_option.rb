class DeliveryOption < ApplicationRecord
  acts_as_paranoid

  has_many :budgets
  has_many :sub_delivery_options, dependent: :destroy

  accepts_nested_attributes_for :sub_delivery_options, allow_destroy: true

  has_paper_trail

  validates :name, presence: true
end