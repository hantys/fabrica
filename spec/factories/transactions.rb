FactoryBot.define do
  factory :transaction do
    transactionable { "" }
    action { 1 }
    obs { "MyText" }
    bank { nil }
  end
end
