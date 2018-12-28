class AddDeletedAtToCategoryProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :category_products, :deleted_at, :datetime

    add_index :category_products, :deleted_at

    rename_column :cred_cards, :valid, :valid_card
  end
end
