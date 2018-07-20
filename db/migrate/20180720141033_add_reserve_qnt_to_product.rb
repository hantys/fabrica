class AddReserveQntToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :reserve_qnt, :float, default: 0
    add_column :products, :reserve, :float, default: 0
    add_column :budget_products, :reserve, :float, default: 0
  end
end
