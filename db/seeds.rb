User.create(username: 'pedro', email: 'pedro.fausto@hotmail.com',password: '12345678')

10.times do
  RawMaterial.create! name: Faker::Commerce.product_name
end

10.times do
  Composition.create! name: Faker::Commerce.product_name, kind: rand(0..1), raw_materials: RawMaterial.order('RANDOM()').limit(rand(1..4))
end
