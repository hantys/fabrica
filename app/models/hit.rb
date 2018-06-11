class Hit < ApplicationRecord
  belongs_to :composition
  has_one :stock_final_product
  has_many :hit_items, dependent: :destroy
  has_many :raw_materials, through: :hit_items

  accepts_nested_attributes_for :hit_items, allow_destroy: true

  has_paper_trail

  validates_associated :hit_items
  validates_presence_of :hit_items

end
