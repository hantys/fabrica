class BillReceivableInstallment < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }
  belongs_to :bill_receivable, -> { with_deleted }

  has_paper_trail
end
