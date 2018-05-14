class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :company_name
      t.string :fantasy_name
      t.string :cpf
      t.string :cnpj
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :cep
      t.string :ie
      t.string :bank
      t.string :ag
      t.string :cc
      t.string :variation
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.string :phone1
      t.string :phone2

      t.timestamps
    end
  end
end
