class AddStatusToBudget < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :status, :integer, default: 0
  end
end
