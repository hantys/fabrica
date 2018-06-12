class RenameColunmBudget < ActiveRecord::Migration[5.2]
  def change
    rename_column :budgets, :delivery_options, :delivery_option_id
    rename_column :budgets, :type_of_payment, :type_of_payment_id

    add_index :budgets, :delivery_option_id
    add_index :budgets, :type_of_payment_id
  end
end