class BillPayableInstallment < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }
  belongs_to :cred_card, -> { with_deleted }

  has_paper_trail
end
