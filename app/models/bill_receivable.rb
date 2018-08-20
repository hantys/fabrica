class BillReceivable < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader

  belongs_to :budget, -> { with_deleted }
  belongs_to :category, -> { with_deleted }
  belongs_to :revenue, -> { with_deleted }

  has_paper_trail
end
