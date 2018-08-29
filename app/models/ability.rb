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
      can :budget_pdf, Budget
      can :order_service, Budget
      can :update_status, Budget
      can :product_cod, Product
      cannot [:update, :destroy], Budget, status: [3,4]
      can :reports_admin, :report
      can :home_access, :home
    end
    if user.has_role? :manager
      can :update_status, Budget
      can :crud, :all
      can :product_cod, Product
      cannot [:create, :read, :update, :destroy], DeliveryOption
      cannot [:create, :read, :update, :destroy], TypeOfPayment
      can :budget_pdf, Budget
      can :order_service, Budget
      cannot [:update, :destroy], Budget, status: [3,4]
      can :reports_manager, :report
      can :home_access, :home
    end
    if user.has_role? :representative
      can [:read, :update, :destroy], Budget, employee_id: user.employee.id
      can :budget_pdf, Budget
      can :read, [Product]
      can :product_cod, Product
      can [:read, :update], Client, employee_id: user.employee.id
      can :create, [Budget, Client]
      can [:read, :update], User, id: user.id
      can :update_status, Budget, status: [0]
      cannot [:update, :destroy], Budget, status: [3,4]
      can :home_access, :home
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
