class CreateStockRawMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_raw_materials do |t|
      t.references :raw_material, foreign_key: true
      t.float :weight
      t.float :weight_out
      t.float :price

      t.timestamps
    end
  end
end
