class Revenue < ApplicationRecord
  acts_as_paranoid

  belongs_to :category, -> { with_deleted }

  has_paper_trail

  validates :name, presence: true

end
