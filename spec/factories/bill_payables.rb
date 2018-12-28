FactoryBot.define do
  factory :bill_payable do
    provider_contract nil
    status 1
    category nil
    revenue nil
    obs "MyText"
    file "MyString"
    total_value 1.5
  end
end
