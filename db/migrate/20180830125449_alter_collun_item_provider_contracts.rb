class AlterCollunItemProviderContracts < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:item_provider_contracts, :budget, foreign_key: true)
    add_column :item_provider_contracts, :name, :string
  end
end
