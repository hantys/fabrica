class CreateBudgetItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_items do |t|
      t.references :composition, foreign_key: true
      t.string :cod
      t.string :name
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
