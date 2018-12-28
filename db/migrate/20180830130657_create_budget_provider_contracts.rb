class CreateBudgetProviderContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_provider_contracts do |t|
      t.references :budget, foreign_key: true
      t.references :provider_contract, foreign_key: true
      t.float :value
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :budget_provider_contracts, :deleted_at
  end
end
