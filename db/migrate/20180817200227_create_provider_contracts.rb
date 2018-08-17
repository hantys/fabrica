class CreateProviderContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_contracts do |t|
      t.string :name
      t.references :provider, foreign_key: true
      t.text :obs
      t.float :total_value
      t.float :partil_value
      t.integer :staus

      t.timestamps
    end
  end
end
