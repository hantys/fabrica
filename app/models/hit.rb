class Hit < ApplicationRecord
  belongs_to :composition
  has_one :stock_final_product
  has_many :hit_items, dependent: :destroy
  has_many :raw_materials, through: :hit_items
end
