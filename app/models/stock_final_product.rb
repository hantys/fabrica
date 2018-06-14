class StockFinalProduct < ApplicationRecord
  acts_as_paranoid

  enum kind: {raw_material: 0, product: 1}

  belongs_to :product, optional: true
  belongs_to :hit, optional: true

  has_paper_trail

  before_create :save_estimated
  after_create :set_estimated_weight
  after_create :set_cost

  validates_presence_of :amount

  def save_estimated
    if self.kind == "raw_material"
      hit = Hit.find self.hit_id
      hit.hit_items.includes(:raw_material).each do |hit_item|
        stocks = hit_item.raw_material.stock_raw_materials.where('weight_out > 0').order(:id)
        @i = 0
        @weight = hit_item.weight

        while @weight > 0  do
          stock = stocks[@i]
          if weight <= stock.weight_out
            HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: @weight)
            @weight = 0
          else
            rest = @weight - stock.weight_out
            HitItemStock.create!(stock_raw_material_id: stock.id, hit_item: hit_item, weight: (@weight - rest))
            @weight = rest
          end
          @i +=1
        end
      end
      hit.update used: true
    else
      # implementar calculo para composicao
    end
  end

  def set_estimated_weight
    if self.kind == "raw_material"
      self.weight = self.hit.hit_items.sum(:weight)
      self.estimated_weight = self.hit.hit_items.sum(:weight)+self.hit.residue
      self.save!
      composition = self.hit.composition
      composition.amount = composition.amount + self.amount
      composition.weight = composition.amount + self.weight
      composition.save!
    else
      # implementar calculo para composicao
    end
  end

  def set_cost
    @calc_cost = 0
    if self.kind == "raw_material"
      self.hit.hit_items.includes(:hit_item_stocks).each do |hit_item|
        hit_item.hit_item_stocks.each do |item|
          stock = item.stock_raw_material
          @calc_cost = @calc_cost+((stock.price*item.weight)/stock.weight)
        end
      end
    else
      # implementar calculo para composicao
    end
    self.update! cost: @calc_cost
  end
end