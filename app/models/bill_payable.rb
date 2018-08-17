class BillPayable < ApplicationRecord
  belongs_to :provider_contract
  belongs_to :category
  belongs_to :revenue
end
