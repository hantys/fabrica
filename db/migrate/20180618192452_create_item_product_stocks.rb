class CreateItemProductStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :item_product_stocks do |t|
      t.references :product, foreign_key: true
      t.integer :derivative_id
      t.references :stock_final_product, foreign_key: true
      t.float :qnt
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :item_product_stocks, :deleted_at
    add_index :item_product_stocks, :derivative_id
  end
end
