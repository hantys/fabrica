class AddBalanceToBank < ActiveRecord::Migration[5.2]
  def change
    add_column :banks, :balance, :float, :default => 0
  end
end
