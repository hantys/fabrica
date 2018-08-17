class CreateItemProviderContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :item_provider_contracts do |t|
      t.references :budget, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
