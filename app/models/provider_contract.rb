class ProviderContract < ApplicationRecord
  acts_as_paranoid

  belongs_to :provider, -> { with_deleted }
  has_many :item_provider_contracts, dependent: :destroy

  accepts_nested_attributes_for :item_provider_contracts, allow_destroy: true

end
