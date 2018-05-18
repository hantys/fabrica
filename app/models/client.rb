class Client < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :city, optional: true
  belongs_to :employee, optional: true
end
