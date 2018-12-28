class Employee < ApplicationRecord
  acts_as_paranoid

  belongs_to :state, optional: true
  belongs_to :city, optional: true
  has_one :user
  has_many :clients

  has_paper_trail

  validates :name, presence: true
  validates :office, presence: true
  validates :phone1, presence: true
  validates :cpf, presence: true
  validates :cep, presence: true
  validates :number, presence: true
end
