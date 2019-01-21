class AddModifyToBillReceivable < ActiveRecord::Migration[5.2]
  def change
    change_column_default :bill_receivables, :type_receivable, 0
  end
end
