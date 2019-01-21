class AddHitIdToStockFinalProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_final_products, :hit, foreign_key: true
  end
end
