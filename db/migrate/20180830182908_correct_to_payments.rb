class CorrectToPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :bill_receivable_installments, :date, :string
    remove_column :bill_payable_installments, :date, :string

    add_column :bill_receivable_installments, :date, :date
    add_column :bill_payable_installments, :date, :date

    add_column :bill_receivable_installments, :payday, :date
    add_column :bill_payable_installments, :payday, :date
  end
end