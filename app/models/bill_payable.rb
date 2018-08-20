class BillPayable < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FilesUploader


  belongs_to :provider_contract, -> { with_deleted }
  belongs_to :category, -> { with_deleted }, optional: true
  belongs_to :revenue, -> { with_deleted }, optional: true

  has_many :bill_payable_installments, dependent: :destroy

  accepts_nested_attributes_for :bill_payable_installments, allow_destroy: true


  has_paper_trail

  validates :total_value, numericality: { greater_than: 0 }
  validates :total_value, presence: true

end
