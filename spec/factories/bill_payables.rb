FactoryBot.define do
  factory :bill_payable do
  
    status{ 1}

    obs {"MyText"}
    file {"MyString"}
    total_value {1.5}
  end
end
