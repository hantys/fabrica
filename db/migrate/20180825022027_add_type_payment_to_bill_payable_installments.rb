class AddTypePaymentToBillPayableInstallments < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payable_installments, :type_payment, :integer, default: 0
    add_column :bill_payable_installments, :bank_name, :string
    add_column :bill_payable_installments, :cc, :string
    add_column :bill_payable_installments, :ag, :string
    add_column :bill_payable_installments, :op, :string
  end
end
