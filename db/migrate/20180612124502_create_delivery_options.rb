class CreateDeliveryOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
