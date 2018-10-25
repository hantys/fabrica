class Client < ApplicationRecord
  acts_as_paranoid

  belongs_to :state
  belongs_to :city
  belongs_to :employee, -> { with_deleted }
  has_many :product_customs, dependent: :destroy

  accepts_nested_attributes_for :product_customs, allow_destroy: true

  has_paper_trail

  validates :company_name, presence: true
  validates :phone1, presence: true
  validates :cep, presence: true
  validates :number, presence: true
  validates_presence_of :cpf, :unless => :cpf?
  validates_presence_of :cnpj, :unless => :cnpj?

  validates_uniqueness_of :cpf, :if => Proc.new{|client| not client.cpf.empty?}
  validates_uniqueness_of :cnpj, :if => Proc.new{|client| not client.cnpj.empty?}

  def cpf?
    self.cnpj.present?
  end

  def cnpj?
    self.cpf.present?
  end

  def custom_products
    product_customs = []
    client_id = self.id
    Product.all.each do |product|
      product_customs << {product_id: product.id, client_id: client_id, value: product.price}
    end
    ActiveRecord::Base.transaction do
      ProductCustom.create(product_customs)
    end
  end
end