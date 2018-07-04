class CreateOutOfStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :out_of_stocks do |t|
      t.references :budget, foreign_key: true
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.float :qnt
      t.float :cost
      t.float :value
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :out_of_stocks, :deleted_at
  end
end
