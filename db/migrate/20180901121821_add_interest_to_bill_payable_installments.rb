class AddInterestToBillPayableInstallments < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payable_installments, :interest, :float, default: 0
  end
end
