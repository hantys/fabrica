
User.create!(username: 'pedro', email: 'pedro.fausto@hotmail.com',password: '12345678')

10.times do
  RawMaterial.create! name: Faker::Commerce.product_name
end

10.times do
  Composition.create! name: Faker::Commerce.product_name, kind: 0, raw_materials: RawMaterial.order('RANDOM()').limit(rand(1..4))
end

5.times do
  composition = Composition.new name: Faker::Commerce.product_name, kind: 1, sub_compositions: Composition.order('RANDOM()').limit(rand(1..2))
  composition.save(validate: false)
end
