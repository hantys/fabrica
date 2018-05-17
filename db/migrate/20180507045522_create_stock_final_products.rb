class CreateStockFinalProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_final_products do |t|
      t.string :name
      t.integer :kind
      t.references :composition, foreign_key: true
      t.float :weight
      t.float :estimated_weight
      t.float :cost

      t.timestamps
    end
  end
end
