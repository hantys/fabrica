class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :name
      t.float :weight
      t.integer :kind
      t.integer :parent_composition_id

      t.timestamps
    end

    # add_index :compositions, :parent_composition_id
  end
end
