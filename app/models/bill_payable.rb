class BillPayable < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader


  belongs_to :provider_contract, -> { with_deleted }
  belongs_to :category, -> { with_deleted }, optional: true
  belongs_to :revenue, -> { with_deleted }, optional: true

  has_paper_trail

  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true

end
