class Compositional < ApplicationRecord
  belongs_to :raw_material, touch: true
  belongs_to :composition, touch: true
end
