class Hit < ApplicationRecord
  # acts_as_paranoid

  before_destroy :check_routine_trigger

  belongs_to :composition
  belongs_to :product
  has_one :stock_final_product
  has_many :hit_items, dependent: :destroy
  has_many :raw_materials, through: :hit_items

  accepts_nested_attributes_for :hit_items, allow_destroy: true

  has_paper_trail

  validates_associated :hit_items
  validates_presence_of :hit_items


  private
    def check_routine_trigger
      if self.used
        errors.add :base, "Não pode ser apagado. Já foi usada"
        false
        # Rails 5
        throw(:abort)
      end
    end

end
