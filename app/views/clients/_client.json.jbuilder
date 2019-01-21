json.extract! client, :id, :company_name, :fantasy_name, :cpf, :street, :number, :neighborhood, :cep, :cnpj, :ie, :state_id, :city_id, :phone1, :phone2, :employee_id, :created_at, :updated_at
json.url client_url(client, format: :json)
