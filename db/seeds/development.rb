puts "### Cidades e Estados"
load "db/imports/states_cities.rb"

puts "### Itens do orcamento"
load "db/imports/product.rb"

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

puts '#Funcionatios'
(1..20).each do |i|
  puts "#inset #{i} de 20"
  state = State.find(rand(1..27))
  Employee.create name: Faker::Name.name, email: FFaker::Internet.safe_email, cpf: FFaker::IdentificationBR.pretty_cpf, phone1:FFaker::PhoneNumberBR.mobile_phone_number, state: state, city: state.cities.sample(1).last, office: FFaker::JobBR.title, cep: FFaker::AddressBR.zip_code, number: rand(100..9999)
end

puts '#Usuario'
User.create!(username: 'pedro', email: 'pedro.fausto@hotmail.com', password: '12345678', employee: Employee.last, roles: 'admin')
User.create!(username: 'teste', email: 'teste@hotmail.com', password: '12345678', employee: Employee.last(2).first, roles: 'representative')


puts '#Materia prima'
10.times do |i|
  puts "#inset #{i} de 10"
  RawMaterial.create! name: Faker::Commerce.product_name
end

puts '#Estoque de materia prima'
100.times do |i|
  puts "#inset #{i} de 100"
  StockRawMaterial.create! raw_material_id: rand(1..10), weight: rand(60.2..100.1), price: rand(30.1..99.9)
end

puts '#Composicao de materia prima'
10.times do |i|
  puts "#inset #{i} de 10"
  Composition.create! name: Faker::Commerce.product_name, raw_materials: RawMaterial.order('RANDOM()').limit(rand(1..4))
end

puts '#Batida'
20.times do |i|
  puts "#inset #{i} de 20"
  composition = Composition.order('RANDOM()').last
  hit_items = []
  composition.raw_materials.each do |raw_material|
    hit_items << HitItem.new(raw_material_id: raw_material.id, weight: rand(1.2..9.9))
  end
  hit = Hit.create! product: Product.where(derivative: false).order('RANDOM()').first, composition: composition, hit_items: hit_items
end

puts '#clientes e fornecedores'
(1..20).each do |i|
  puts "#inset #{i} de 20"
  state = State.find(rand(1..27))
  client = Client.new company_name: "#{Faker::Company.name} #{i}" ,fantasy_name: "#{Faker::Company.name} #{i}", state: state, city: state.cities.sample(1).last, employee: Employee.find(rand(1..20)), cnpj: FFaker::IdentificationBR.pretty_cnpj, phone1:FFaker::PhoneNumberBR.mobile_phone_number, cep: FFaker::AddressBR.zip_code, number: rand(100..9999)
  provider = Provider.new company_name: "#{Faker::Company.name} #{i}" ,fantasy_name: "#{Faker::Company.name} #{i}", state: state, city: state.cities.sample(1).last, cnpj: FFaker::IdentificationBR.pretty_cnpj, phone1:FFaker::PhoneNumberBR.mobile_phone_number, cep: FFaker::AddressBR.zip_code, number: rand(100..9999)
  client.save(validate: false)
  provider.save(validate: false)
end
