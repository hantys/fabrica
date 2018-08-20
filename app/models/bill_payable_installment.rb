class BillPayableInstallment < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }, optional: true
  belongs_to :cred_card, -> { with_deleted }, optional: true
  belongs_to :bill_payable, -> { with_deleted }, touch: true, optional: true

  has_paper_trail
end
