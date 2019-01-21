FactoryBot.define do
  factory :out_of_stock do
    budget {nil}
    user {nil}
    product {nil}
    qnt {1.5}
    cost {1.5}
    value {1.5}
  end
end
