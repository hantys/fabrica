FactoryBot.define do
  factory :bill_payable_installment do

    billet {false}
    code {"MyString"}
    file {"MyString"}
    date {"MyString"}
    value {1.5}
    status {1}
  end
end
