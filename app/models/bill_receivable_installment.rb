class BillReceivableInstallment < ApplicationRecord
  acts_as_paranoid

  enum status: { pending: 0, paid: 1 }

  mount_uploader :file, FilesUploader

  belongs_to :bank, -> { with_deleted }
  belongs_to :bill_receivable, -> { with_deleted }, optional: true, touch: true

  has_paper_trail

  validates :payday, presence: true, if: Proc.new{|item| item.status == 'paid' }
  validates :file, presence: true, if: Proc.new{|item| item.status == 'paid' }

  validates :value, numericality: { greater_than: 0 }
  validates :bank, presence: true
  validates :date, presence: true
end
