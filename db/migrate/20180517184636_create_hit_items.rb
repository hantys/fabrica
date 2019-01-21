class CreateHitItems < ActiveRecord::Migration[5.2]
  def change
    create_table :hit_items do |t|
      t.references :raw_material, foreign_key: true
      t.references :hit, foreign_key: true
      t.float :weight, default: 0

      t.timestamps
    end
  end
end
