class HitItemStock < ApplicationRecord
  acts_as_paranoid

  belongs_to :stock_raw_material
  belongs_to :hit_item

  has_paper_trail

  after_create :update_weight

  def update_weight
    stock = self.stock_raw_material
    stock.weight_out = stock.weight_out - self.weight
    stock.save!
  end
end
