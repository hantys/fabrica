FactoryBot.define do
  factory :composition do
    name {Faker::Commerce.material}
    weight{ 1.5}
    kind {1}
    parent_composition_id {nil}
  end
end
