class HitItemStock < ApplicationRecord
  belongs_to :stock_raw_material
  belongs_to :hit_item

  after_create :update_weight

  def update_weight
    stock = self.stock_raw_material
    stock.weight_out = stock.weight_out - self.weight
    stock.save!
  end
end
