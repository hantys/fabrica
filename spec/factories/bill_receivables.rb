FactoryBot.define do
  factory :bill_receivable do
    type_receivable "MyString"
    references ""
    name_other "MyString"
    cpf_other "MyString"
    cnpj_other "MyString"
    phone_other "MyString"
    obs_other "MyText"
    references ""
    references ""
    status 1
    obs "MyText"
    file "MyString"
    total_value 1.5
  end
end
