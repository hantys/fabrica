class CreateRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :revenues do |t|
      t.string :name
      t.references :category

      t.timestamps
    end
  end
end
