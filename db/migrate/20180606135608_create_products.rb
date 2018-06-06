class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :cod
      t.string :name
      t.float :price, default: 0
      t.float :weight, default: 0
      t.float :qnt, default: 0

      t.timestamps
    end
  end
end
