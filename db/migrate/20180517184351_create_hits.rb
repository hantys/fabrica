class CreateHits < ActiveRecord::Migration[5.2]
  def change
    create_table :hits do |t|
      t.string :name
      t.float :residue, default: 0
      t.boolean :used, default: false
      t.references :composition, foreign_key: true

      t.timestamps
    end
  end
end
