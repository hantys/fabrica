json.extract! bill_payable, :id, :provider_contract_id, :status, :category_id, :revenue_id, :obs, :file, :total_value, :created_at, :updated_at
json.url bill_payable_url(bill_payable, format: :json)
