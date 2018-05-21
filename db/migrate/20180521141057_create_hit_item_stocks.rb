class CreateHitItemStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :hit_item_stocks do |t|
      t.references :hit_item
      t.references :stock_raw_material
      t.float :weight, default: 0

      t.timestamps
    end
  end
end
