class AddQntOutToStockFinalProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_final_products, :qnt_out, :float
    add_column :stock_final_products, :amount_out, :float
  end
end
