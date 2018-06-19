class AddSubTypePaymentToBudget < ActiveRecord::Migration[5.2]
  def change
    add_reference :budgets, :sub_type_payment, foreign_key: true
  end
end
