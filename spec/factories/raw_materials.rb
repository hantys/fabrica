FactoryBot.define do
  factory :raw_material do
    sequence(:name) { |n| Faker::Commerce.material+n.to_s }
    # name {Faker::Commerce.material}
    amount {1.5}
  end
end
