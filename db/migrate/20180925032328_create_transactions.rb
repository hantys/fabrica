class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :bank, foreign_key: true
      t.belongs_to :transactionable, polymorphic: true, index: { name: 'index_transactionable' }
      t.integer :action
      t.integer :type_action
      t.float :value, default: 0
      t.text :obs, default: ''
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
