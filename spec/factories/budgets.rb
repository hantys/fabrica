FactoryBot.define do
  factory :budget do
    name {"MyString"}

    value {1.5}
    deadline{ "2018-05-30"}
    delivery_options {1}
    payment_term {1}
    type_of_payment {1}
    discount {1.5}
    discount_type {1}
  end
end
