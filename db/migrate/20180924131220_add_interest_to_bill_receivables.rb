class AddInterestToBillReceivables < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_receivable_installments, :interest, :float, default: 0
    add_column :bill_receivables, :interest, :float, default: 0
  end
end
