json.extract! employee, :id, :name, :cpf, :email, :office, :bank, :ag, :cc, :variation, :street, :number, :string, :neighborhood, :cep, :state_id, :city_id, :phone1, :phone2, :user_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
