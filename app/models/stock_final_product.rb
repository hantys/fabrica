class StockFinalProduct < ApplicationRecord
  belongs_to :composition
  belongs_to :hit
end
