class AddDerivativeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :derivative, :boolean, default: false
  end
end
