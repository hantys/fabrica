class BillReceivable < ApplicationRecord
  acts_as_paranoid

  enum status: { pending: 0, late: 1, paid: 2 }
  enum type_receivable: { budget: 0, other: 1 }

  mount_uploader :file, FilesUploader

  belongs_to :budget, -> { with_deleted }
  belongs_to :category, -> { with_deleted }
  belongs_to :revenue, -> { with_deleted }

  has_many :bill_receivable_installments, dependent: :destroy

  accepts_nested_attributes_for :bill_receivable_installments, allow_destroy: true

  has_paper_trail
end
