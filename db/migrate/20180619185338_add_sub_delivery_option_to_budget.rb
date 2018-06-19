class AddSubDeliveryOptionToBudget < ActiveRecord::Migration[5.2]
  def change
    add_reference :budgets, :sub_delivery_option, foreign_key: true
  end
end
