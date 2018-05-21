class StockFinalProduct < ApplicationRecord
  belongs_to :composition
  belongs_to :hit

  before_create :get_estimated

  def get_estimated
    hit = Hit.find self.hit_id
    hit.hit_items.each do |hit_item|

    end
  end
end
