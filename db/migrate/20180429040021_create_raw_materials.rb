class CreateRawMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_materials do |t|
      t.string :name
      t.string :slug_name
      t.float :amount, default: 0

      t.timestamps
    end
    add_index :raw_materials, :name, unique: true
  end
end
