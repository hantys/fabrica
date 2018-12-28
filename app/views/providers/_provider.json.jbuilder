json.extract! provider, :id, :company_name, :fantasy_name, :cpf, :cnpj, :street, :number, :neighborhood, :cep, :ie, :bank, :ag, :cc, :variation, :state_id, :city_id, :phone1, :phone2, :created_at, :updated_at
json.url provider_url(provider, format: :json)
