class BillPayableInstallment < ApplicationRecord
  belongs_to :bank
  belongs_to :cred_card
end
