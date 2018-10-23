class CreateProductCustoms < ActiveRecord::Migration[5.2]
  def change
    create_table :product_customs do |t|
      t.references :product, foreign_key: true
      t.references :client, foreign_key: true
      t.float :value, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :product_customs, :deleted_at
  end
end
