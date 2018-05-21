
User.create!(username: 'pedro', email: 'pedro.fausto@hotmail.com',password: '12345678')

10.times do
  RawMaterial.create! name: Faker::Commerce.product_name
end

100.times do
  StockRawMaterial.create! raw_material_id: rand(1..10), weight: rand(60.2..100.1), price: rand(30.1..99.9)
end

10.times do
  Composition.create! name: Faker::Commerce.product_name, kind: 0, raw_materials: RawMaterial.order('RANDOM()').limit(rand(1..4))
end

5.times do
  composition = Composition.new name: Faker::Commerce.product_name, kind: 1, sub_compositions: Composition.order('RANDOM()').limit(rand(1..2))
  composition.save(validate: false)
end

20.times do
  composition = Composition.where(kind: 0).order('RANDOM()').last
  hit_items = []
  composition.raw_materials.each do |raw_material|
    hit_items << HitItem.new(raw_material_id: raw_material.id, weight: rand(1.2..9.9))
  end
  hit = Hit.create! name: Faker::Commerce.product_name, residue: rand(1..10.1), composition: composition, hit_items: hit_items
end