class Category < ApplicationRecord
  acts_as_paranoid

  has_many :revenues, dependent: :destroy
  accepts_nested_attributes_for :revenues, allow_destroy: true

  has_paper_trail

  validates :name, presence: true

end
