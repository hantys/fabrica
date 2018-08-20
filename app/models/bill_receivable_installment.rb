class BillReceivableInstallment < ApplicationRecord
  acts_as_paranoid

  belongs_to :bank, -> { with_deleted }
end
