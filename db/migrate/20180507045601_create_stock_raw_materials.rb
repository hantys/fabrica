class CreateStockRawMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_raw_materials do |t|
      t.references :raw_material, foreign_key: true
      t.float :weight, default: 0
      t.float :weight_out, default: 0
      t.float :price, default: 0

      t.timestamps
    end
  end
end
