class AddFileToPayToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payable_installments, :file_to_pay, :string
    add_column :bill_receivable_installments, :file_to_pay, :string
  end
end
