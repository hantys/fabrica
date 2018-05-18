class HitItem < ApplicationRecord
  belongs_to :raw_material
  belongs_to :hit

  validates :weight, numericality: { greater_than: 0 }
  validates :weight, presence: true
end
