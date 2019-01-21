FactoryBot.define do
  factory :op_transaction do
    bank { nil }
    action { 1 }
    type_action { 1 }
    value { 1.5 }
    obs { "MyText" }
    transactionable { nil }
    deleted_at { "2018-09-25 09:34:36" }
  end
end
