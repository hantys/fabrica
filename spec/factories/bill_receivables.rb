FactoryBot.define do
  factory :bill_receivable do
    type_receivable 1
    budget nil
    name_other "MyString"
    cpf_other "MyString"
    cnpj_other "MyString"
    phone_other "MyString"
    obs_other "MyText"
    category nil
    revenue nil
    status 1
    obs "MyText"
    file "MyString"
    total_value 1.5
  end
end
