json.extract! product, :id, :cod, :name, :price, :weight, :qnt, :created_at, :updated_at
json.url product_url(product, format: :json)
