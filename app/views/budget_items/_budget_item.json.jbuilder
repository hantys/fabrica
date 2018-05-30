json.extract! budget_item, :id, :composition_id, :cod, :name, :description, :price, :created_at, :updated_at
json.url budget_item_url(budget_item, format: :json)
