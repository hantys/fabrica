class ProviderContract < ApplicationRecord
  acts_as_paranoid

  enum status: { active: 0, finish: 1 }

  belongs_to :provider, -> { with_deleted }
  has_many :item_provider_contracts, dependent: :destroy

  accepts_nested_attributes_for :item_provider_contracts, allow_destroy: true

  has_paper_trail

  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true
  validates :name, presence: true
end
