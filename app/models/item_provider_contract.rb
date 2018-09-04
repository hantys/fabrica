class ItemProviderContract < ApplicationRecord
  acts_as_paranoid

  belongs_to :provider_contract, -> { with_deleted }, touch: true, optional: true

  has_paper_trail

  validates :value, numericality: { greater_than: 0 }
  validates :value, presence: true
  validates :name, presence: true


end
