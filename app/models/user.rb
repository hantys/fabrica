class User < ApplicationRecord
  attr_accessor :login

  ROLES = %i[admin manager representative]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :employee, touch: true#, optional: true
  has_many :out_of_stocks, dependent: :destroy
  has_many :op_transactions, as: :transactionable

  has_paper_trail

  validates :username, uniqueness: true
  validates :employee, uniqueness: true
  validates :username, presence: true
  validates :roles_mask, presence: true
  validates :roles_mask, numericality: { greater_than: 0, message: "precisa ser selecionada" }

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    # assuming you have deleted_at column added already
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end
end

