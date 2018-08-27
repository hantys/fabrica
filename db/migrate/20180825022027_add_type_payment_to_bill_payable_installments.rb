class AddTypePaymentToBillPayableInstallments < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payable_installments, :type_payment, :integer, default: 0
  end
end
