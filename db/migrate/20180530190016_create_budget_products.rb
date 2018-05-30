class CreateBudgetProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_products do |t|
      t.references :budget, foreign_key: true
      t.references :budget_item, foreign_key: true
      t.float :unit_value
      t.float :qnt
      t.float :total_value
      t.float :discount
      t.integer :discount_type

      t.timestamps
    end
  end
end
