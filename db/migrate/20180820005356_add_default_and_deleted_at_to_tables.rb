class AddDefaultAndDeletedAtToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :bill_receivable_installments, :deleted_at, :datetime
    add_column :bill_receivables, :deleted_at, :datetime
    add_column :bill_payable_installments, :deleted_at, :datetime
    add_column :bill_payables, :deleted_at, :datetime
    add_column :item_provider_contracts, :deleted_at, :datetime
    add_column :provider_contracts, :deleted_at, :datetime
    add_column :banks, :deleted_at, :datetime
    add_column :cred_cards, :deleted_at, :datetime
    add_column :revenues, :deleted_at, :datetime
    add_column :categories, :deleted_at, :datetime


    add_index :bill_receivable_installments, :deleted_at
    add_index :bill_receivables, :deleted_at
    add_index :bill_payable_installments, :deleted_at
    add_index :bill_payables, :deleted_at
    add_index :item_provider_contracts, :deleted_at
    add_index :provider_contracts, :deleted_at
    add_index :banks, :deleted_at
    add_index :cred_cards, :deleted_at
    add_index :revenues, :deleted_at
    add_index :categories, :deleted_at

    add_reference :item_provider_contracts, :provider_contract, foreign_key: true

    rename_column(:provider_contracts, :staus, :status)
    rename_column(:cred_cards, :catd_final, :card_final)

    change_column_default :bill_receivable_installments, :value, 0
    change_column_default :bill_receivable_installments, :status, 0
    change_column_default :bill_receivables, :status, 0
    change_column_default :bill_receivables, :total_value, 0
    change_column_default :bill_payable_installments, :value, 0
    change_column_default :bill_payable_installments, :status, 0
    change_column_default :bill_payables, :status, 0
    change_column_default :bill_payables, :total_value, 0
    change_column_default :item_provider_contracts, :value, 0
    change_column_default :provider_contracts, :status, 0
    change_column_default :provider_contracts, :total_value, 0
    change_column_default :provider_contracts, :partil_value, 0

  end
end
