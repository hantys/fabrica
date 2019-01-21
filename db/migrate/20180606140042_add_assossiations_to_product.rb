class AddAssossiationsToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :budget_products, :product, foreign_key: true
    add_reference :stock_final_products, :product, foreign_key: true
  end
end
