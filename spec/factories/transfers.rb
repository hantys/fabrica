FactoryBot.define do
  factory :transfer do
    user { nil }
    bank { nil }
    value { 1.5 }
    obs { "MyText" }
  end
end
