class BillPayableInstallment < ApplicationRecord
  acts_as_paranoid

  belongs_to :bank, -> { with_deleted }
  belongs_to :cred_card, -> { with_deleted }
end
