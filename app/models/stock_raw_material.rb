class StockRawMaterial < ApplicationRecord
  acts_as_paranoid

  before_create :set_weight_out #seta peso de saida na criação
  before_destroy :check_routine_trigger #faz o rollback do peso na materia-prima quando a entrada de estoque e deletada
  after_create :update_stock_raw_material #atualiza o peso da materia-prima quando tem uma entrada no estoque
  before_save :weight_refresh_trigger #atualiza o peso da materia-prima quando ocorre alguma retirada

  belongs_to :raw_material

  has_paper_trail

  validates :weight, presence: true
  validates :price, presence: true
  validates :raw_material_id, presence: true


  private
    def set_weight_out
      self.weight_out = self.weight
    end

    def check_routine_trigger
      if self.weight != self.weight_out
        # raise "não pode ser apagado. Já existe uma saida desse material"
        # errors[:base] << "não pode ser apagado. Já existe uma saida desse material"
        # return false
        errors.add :base, "Não pode ser apagado. Já existe uma saida desse material"
        false
        # Rails 5
        throw(:abort)
      else
        self.raw_material.update(amount: self.raw_material.amount - self.weight)
      end
    end

    def update_stock_raw_material
      self.raw_material.update(amount: self.raw_material.amount + weight)
    end

    def weight_refresh_trigger
      if self.will_save_change_to_attribute?(:weight_out)
        self.raw_material.update(amount: self.raw_material.amount - (self.weight_out_change_to_be_saved[0]-self.weight_out_change_to_be_saved[1]))
      end
    end

end