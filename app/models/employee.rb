class Employee < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :city, optional: true
  has_one :user
end
