FactoryBot.define do
  factory :compositional do
    raw_material create(:raw_material)
    composition create(:composition)
    weight 1.5
  end
end
