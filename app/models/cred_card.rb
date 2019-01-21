class CredCard < ApplicationRecord
  acts_as_paranoid

  has_paper_trail

  validates :name, presence: true
  validates :card_final, presence: true
  validates :valid_card, presence: true

end