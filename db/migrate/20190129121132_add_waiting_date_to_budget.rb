class AddWaitingDateToBudget < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :waiting_date, :datetime
  end
end
