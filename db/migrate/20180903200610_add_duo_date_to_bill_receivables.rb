class AddDuoDateToBillReceivables < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_receivables, :due_date, :date
    add_index :bill_receivables, :due_date
  end
end
