class AddObsToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :obs, :text, default: ''
  end
end
