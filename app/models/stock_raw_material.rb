class StockRawMaterial < ApplicationRecord
  belongs_to :raw_material

  validates :weight, presence: true
  validates :price, presence: true
  validates :raw_material_id, presence: true

  before_create :update_weight_out

  def update_weight_out
    self.weight_out = self.weight
  end
end
