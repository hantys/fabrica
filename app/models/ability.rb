# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :update, :destroy, to: :save
    alias_action :daily_production, to: :reports_admin
    alias_action :daily_production, to: :reports_manager
    alias_action :index, :find_by_address, :find_city, :find_hit, :produto_primitivo, :find_payment, :find_delivery, to: :home_access

    # Define abilities for the passed in user here. For example:
    #
    # can :manage, :all if user.has_role? :admin
    if user.has_role? :admin
      can :crud, :all
      # cannot :update, ProductCustom
      # cliente
      can %i[create_product_customs list_product_customs update_list_product_customs], Client
      # banco
      can :credit_or_debit, Bank
      can :credit_or_debit_update, Bank
      # pagamento
      can :payment_excel, BillPayable
      can :pays, BillPayable
      can :pays_update, BillPayable
      can :pay_item, BillPayable
      can :pay_item_update, BillPayable
      cannot %i[edit update], BillPayable, status: 2
      # recebimento
      can :receive_item_update, BillReceivable
      can :receive_item, BillReceivable
      can :receives, BillReceivable
      can :receives_update, BillReceivable
      cannot %i[edit update], BillReceivable, status: 2
      # orcamento
      can :reserve_all_budget, Budget
      can :budget_pdf, Budget
      can :order_service, Budget
      can :update_status, Budget
      # produto
      can :product_cod, Product
      # relatorios
      can :reports_admin, :report
      # home
      can :home_access, :home
    end
    if user.has_role? :manager
      can :crud, :all
      # cannot :update, ProductCustom
      # banco
      can :credit_or_debit, Bank
      can :credit_or_debit_update, Bank
      # pagamento
      can :pays, BillPayable
      can :pay_item, BillPayable
      can :pay_item_update, BillPayable
      cannot %i[edit update], BillPayable, status: 2
      # recebimento
      can :receive_item_update, BillReceivable
      can :receive_item, BillReceivable
      can :receives, BillReceivable
      can :receives_update, BillReceivable
      cannot %i[edit update], BillReceivable, status: 2
      # orcamento
      can :reserve_all_budget, Budget
      can :update_status, Budget
      can :budget_pdf, Budget
      can :order_service, Budget
      cannot %i[update destroy], Budget, status: [3, 4]
      # produto
      can :product_cod, Product
      # sistema
      cannot %i[create read update destroy], DeliveryOption
      cannot %i[create read update destroy], TypeOfPayment
      # relatorios
      can :reports_manager, :report
      # home
      can :home_access, :home
    end
    if user.has_role? :representative
      # orcamento
      # cannot :update, ProductCustom
      can %i[read update destroy], Budget, employee_id: user.employee.id
      can :budget_pdf, Budget
      can :update_status, Budget, status: [0]
      cannot %i[update destroy], Budget, status: [3, 4]
      # produto
      can :read, [Product]
      can :product_cod, Product
      # cliente
      can %i[read update], Client, employee_id: user.employee.id
      can :create, [Budget, Client]
      # usuario
      can %i[read update], User, id: user.id
      # home
      can :home_access, :home
    end
    cannot %i[edit update], Transfer
  end
end
