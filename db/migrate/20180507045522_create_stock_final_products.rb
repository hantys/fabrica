class CreateStockFinalProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_final_products do |t|
      t.string :name
      t.integer :kind
      t.references :composition, foreign_key: true
      t.float :weight, default: 0
      t.float :amount, default: 0
      t.float :estimated_weight, default: 0
      t.float :cost, default: 0

      t.timestamps
    end
  end
end
