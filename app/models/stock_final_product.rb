class StockFinalProduct < ApplicationRecord
  enum kind: {raw_material: 0, composition: 1}

  belongs_to :composition
  belongs_to :hit
  has_many :hit_item_stocks, dependent: :destroy
  accepts_nested_attributes_for :hit_item_stocks, allow_destroy: true

  before_create :get_estimated

  def get_estimated
    hit = Hit.find self.hit_id
    hit.hit_items.each do |hit_item|
      stocks = hit_item.raw_material.stock_raw_material.where('weight_out > 0').order(:id)
      @i = 0
      @weight = hit_item.weight

      while @weight > 0  do
        stock = stocks[i]
        if weight <= stock.weight_out
          self.hit_item_stocks << HitItemStock.new stock_raw_material_id: stock.id, weight: @weight
          @weight = 0
        else
          rest = @weight - stock.weight_out
          self.hit_item_stocks << HitItemStock.new stock_raw_material_id: stock.id, weight: (@weight - rest)
          @weight = rest
        end
        @i +=1
      end
    end
  end
end