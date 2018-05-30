json.extract! budget, :id, :name, :client_id, :employee_id, :value, :deadline, :delivery_options, :payment_term, :type_of_payment, :discount, :discount_type, :created_at, :updated_at
json.url budget_url(budget, format: :json)
