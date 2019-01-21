class AddResidueToStockFinalProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_final_products, :residue, :float
    add_column :stock_final_products, :derivative_id, :integer

    add_index :stock_final_products, :derivative_id
  end
end
