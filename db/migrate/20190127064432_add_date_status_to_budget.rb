class AddDateStatusToBudget < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :authorized_date, :datetime
    add_column :budgets, :rejected_date, :datetime
    add_column :budgets, :billed_date, :datetime
    add_column :budgets, :delivered_date, :datetime
    add_column :budgets, :confirm_date, :datetime
  end
end