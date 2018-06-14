class AddDeletedAtToModel < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :deleted_at, :datetime
    add_column :budget_products, :deleted_at, :datetime
    add_column :clients, :deleted_at, :datetime
    add_column :compositionals, :deleted_at, :datetime
    add_column :compositions, :deleted_at, :datetime
    add_column :delivery_options, :deleted_at, :datetime
    add_column :type_of_payments, :deleted_at, :datetime
    add_column :employees, :deleted_at, :datetime
    add_column :hits, :deleted_at, :datetime
    add_column :hit_items, :deleted_at, :datetime
    add_column :hit_item_stocks, :deleted_at, :datetime
    add_column :products, :deleted_at, :datetime
    add_column :providers, :deleted_at, :datetime
    add_column :raw_materials, :deleted_at, :datetime
    add_column :stock_final_products, :deleted_at, :datetime
    add_column :stock_raw_materials, :deleted_at, :datetime

    add_index :budgets, :deleted_at
    add_index :budget_products, :deleted_at
    add_index :clients, :deleted_at
    add_index :compositionals, :deleted_at
    add_index :delivery_options, :deleted_at
    add_index :type_of_payments, :deleted_at
    add_index :employees, :deleted_at
    add_index :hits, :deleted_at
    add_index :hit_items, :deleted_at
    add_index :hit_item_stocks, :deleted_at
    add_index :products, :deleted_at
    add_index :providers, :deleted_at
    add_index :raw_materials, :deleted_at
    add_index :stock_final_products, :deleted_at
    add_index :stock_raw_materials, :deleted_at
  end
end
