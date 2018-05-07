class CreateCompositionals < ActiveRecord::Migration[5.2]
  def change
    create_table :compositionals do |t|
      t.integer :raw_material_id
      t.integer :composition_id
      t.integer :parent_id

      t.timestamps
    end

    add_index :compositionals, [:raw_material_id, :composition_id]
    add_index :compositionals, [:parent_id, :composition_id]
  end
end
