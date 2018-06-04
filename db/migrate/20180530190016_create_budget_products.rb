class CreateBudgetProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_products do |t|
      t.references :budget, foreign_key: true
      t.references :budget_item, foreign_key: true
      t.float :unit_value, default: 0
      t.float :qnt, default: 0
      t.float :total_value, default: 0
      t.float :total_value_with_discount, default: 0
      t.float :discount, default: 0
      t.boolean :discount_type, default: false

      t.timestamps
    end
  end
end
