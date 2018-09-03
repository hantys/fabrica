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
      # pagamento
      can :pays, BillPayable
      can :pays_update, BillPayable
      can :pay_item, BillPayable
      can :pay_item_update, BillPayable
      # orcamento
      can :reserve_all_budget, Budget
      can :budget_pdf, Budget
      can :order_service, Budget
      can :update_status, Budget
      cannot [:update, :destroy], Budget, status: [3,4]
      # produto
      can :product_cod, Product
      # relatorios
      can :reports_admin, :report
      # home
      can :home_access, :home
    end
    if user.has_role? :manager
      can :crud, :all
      # pagamento
      can :pays, BillPayable
      can :pay_item, BillPayable
      can :pay_item_update, BillPayable
      # orcamento
      can :reserve_all_budget, Budget
      can :update_status, Budget
      can :budget_pdf, Budget
      can :order_service, Budget
      cannot [:update, :destroy], Budget, status: [3,4]
      # produto
      can :product_cod, Product
      # sistema
      cannot [:create, :read, :update, :destroy], DeliveryOption
      cannot [:create, :read, :update, :destroy], TypeOfPayment
      # relatorios
      can :reports_manager, :report
      # home
      can :home_access, :home
    end
    if user.has_role? :representative
      # orcamento
      can [:read, :update, :destroy], Budget, employee_id: user.employee.id
      can :budget_pdf, Budget
      can :update_status, Budget, status: [0]
      cannot [:update, :destroy], Budget, status: [3,4]
      # produto
      can :read, [Product]
      can :product_cod, Product
      # cliente
      can [:read, :update], Client, employee_id: user.employee.id
      can :create, [Budget, Client]
      # usuario
      can [:read, :update], User, id: user.id
      # home
      can :home_access, :home
    end
  end
end
