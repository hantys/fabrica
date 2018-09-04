class AddDueDateToBillPayable < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_payables, :due_date, :date
    add_index :bill_payables, :due_date
  end
end
