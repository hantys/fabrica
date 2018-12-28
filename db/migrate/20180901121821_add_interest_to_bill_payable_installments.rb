class AddInterestToBillPayableInstallments < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payable_installments, :interest, :float, default: 0
    add_column :bill_payables, :interest, :float, default: 0
    add_column :budgets, :reserve, :boolean, default: false
  end
end
