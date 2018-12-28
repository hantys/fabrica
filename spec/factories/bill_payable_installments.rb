FactoryBot.define do
  factory :bill_payable_installment do
    bank nil
    cred_card nil
    billet false
    code "MyString"
    file "MyString"
    date "MyString"
    value 1.5
    status 1
  end
end
