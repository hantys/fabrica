# puts "### Cidades e Estados"
# load "db/imports/states_cities.rb"


# puts '#Funcionatios'

# state = State.find(rand(1..27))
# Employee.create name: 'Pedro Fausto', email: 'pedro.fausto@hotmail.com', cpf: FFaker::IdentificationBR.pretty_cpf, phone1:FFaker::PhoneNumberBR.mobile_phone_number, state: state, city: state.cities.sample(1).last, office: FFaker::JobBR.title, cep: FFaker::AddressBR.zip_code, number: rand(100..9999)

# state = State.find(rand(1..27))
# Employee.create name: 'Vitor Alves', email: 'vitor@vitor.com', cpf: FFaker::IdentificationBR.pretty_cpf, phone1:FFaker::PhoneNumberBR.mobile_phone_number, state: state, city: state.cities.sample(1).last, office: FFaker::JobBR.title, cep: FFaker::AddressBR.zip_code, number: rand(100..9999)


# puts '#Usuario'
# User.create!(username: 'pedro', email: 'pedro.fausto@hotmail.com', password: 'pi854098', employee: Employee.first, roles: 'admin')
# User.create!(username: 'vitor', email: 'vitor@vitor.com', password: '12345678', employee: Employee.last, roles: 'admin')

# puts "### Itens do orcamento"
# load "db/imports/budget_items.rb"

puts '#Tipo de entrega'
DeliveryOption.create! name: 'Entrega na loja'
DeliveryOption.create! name: 'Retirada em mãos'

puts '#Tipo de pagamento'
TypeOfPayment.create! name: 'Boleto bancário'
TypeOfPayment.create! name: 'Cartão de crédito'
TypeOfPayment.create! name: 'A vista'
TypeOfPayment.create! name: 'Cheque'
TypeOfPayment.create! name: 'Débito'
TypeOfPayment.create! name: 'Transferência'
TypeOfPayment.create! name: 'Depósito'

Budget.all.each do |budget|
  if budget.delivery_option_id.present?
    budget.delivery_option_id = budget.delivery_option_id+1
  end
  if budget.type_of_payment_id.present?
    budget.type_of_payment_id = budget.type_of_payment_id+1
  end
end