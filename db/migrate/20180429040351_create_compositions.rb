class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :name
      t.float :weight, default: 0
      t.float :amount, default: 0
      t.integer :kind
      t.timestamps
    end
  end
end
