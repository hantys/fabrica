class CorrectToPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :bill_receivable_installments, :date
    remove_column :bill_payable_installments, :date
    add_column :bill_receivable_installments, :date, :date
    add_column :bill_payable_installments, :date, :date
  end
end