class AddBudgetProductToOutOfStock < ActiveRecord::Migration[5.2]
  def change
    add_reference :out_of_stocks, :budget_product, foreign_key: true
  end
end
