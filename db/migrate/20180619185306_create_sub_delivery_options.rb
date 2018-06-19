class CreateSubDeliveryOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_delivery_options do |t|
      t.string :name
      t.references :delivery_option, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :sub_delivery_options, :deleted_at
  end
end
