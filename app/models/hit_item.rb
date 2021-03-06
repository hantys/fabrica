class HitItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :raw_material
  belongs_to :hit

  has_many :hit_item_stocks, dependent: :destroy
  accepts_nested_attributes_for :hit_item_stocks, allow_destroy: true

  has_paper_trail

  validates :weight, numericality: { greater_than: 0 }
  validates :weight, presence: true
end
