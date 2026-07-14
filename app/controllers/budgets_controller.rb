# frozen_string_literal: true

class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_budget_product, only: %i[reserve_product updated_reserve_product]
  load_and_authorize_resource except: %i[find_product reserve_product updated_reserve_product client_options employee_options product_options]
  # GET /budgets
  # GET /budgets.json
  def index
    @q = Budget.ransack(params[:q])

    @budgets = @q.result
                 .accessible_by(current_ability)
                 .includes(:client, :employee, :delivery_option)
                 .order(id: :desc)
                 .page(params[:page])
                 .per(50)
    @budgets.load

    load_selected_filters
  end

  def client_options
    authorize! :read, Client
    clients = Client.accessible_by(current_ability)
    term = params[:q].to_s.strip
    if term.present?
      term = ActiveRecord::Base.sanitize_sql_like(term)
      clients = clients.where('company_name ILIKE :term OR fantasy_name ILIKE :term', term: "%#{term}%")
    end

    results = clients.order(:company_name).limit(50).pluck(:id, :company_name, :fantasy_name).map do |id, company_name, fantasy_name|
      name = fantasy_name.present? ? "#{company_name} (#{fantasy_name})" : company_name
      { id: id, text: name }
    end

    render json: { results: results }
  end

  def employee_options
    authorize! :read, Employee
    employees = Employee.accessible_by(current_ability)
    term = params[:q].to_s.strip
    if term.present?
      term = ActiveRecord::Base.sanitize_sql_like(term)
      employees = employees.where('name ILIKE ?', "%#{term}%")
    end

    results = employees.order(:name).limit(50).pluck(:id, :name).map do |id, name|
      { id: id, text: name }
    end

    render json: { results: results }
  end

  def product_options
    authorize! :read, Product
    products = Product.accessible_by(current_ability)
    term = params[:q].to_s.strip
    if term.present?
      term = ActiveRecord::Base.sanitize_sql_like(term)
      products = products.where('cod ILIKE :term OR name ILIKE :term', term: "%#{term}%")
    end

    results = products.order(:name).limit(50).pluck(:id, :cod, :name).map do |id, cod, name|
      { id: id, text: "#{cod} / #{name}" }
    end

    render json: { results: results }
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  def budget_pdf
    @budget = Budget.find params[:id]
  end

  def order_service
    @budget = Budget.find params[:id]
  end

  def reserve_product
    render partial: 'reserve_product', layout: false
  end

  def updated_reserve_product
    if @budget_product.update!(budget_product_params)
      flash[:success] = 'Quantidade reservada!'
    else
      flash[:error] = 'Reserva não pode ser feita'
    end
  end

  def reserve_all_budget
    budget = Budget.find params[:id]
    if budget.reserve_all
      flash[:success] = 'Alteração na reserva realizada com sucesso!'
    else
      flash[:error] = 'Alteração na reserva não pode ser feita. Tente novamente'
    end
    redirect_back(fallback_location: root_path)
  end

  def update_status
    @budget = Budget.find params[:id]
    if @budget.status == 'waiting'
      case params[:status]
      when 'confirm'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Pedido atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Pedido atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'confirm'
      case params[:status]
      when 'authorized'
        @update_status = true
        if @budget.update status: params[:status].to_sym, obs: params[:obs]
          flash[:success] = 'Pedido atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Pedido atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'authorized'
      case params[:status]
      when 'billed'
        if @budget.billed_budget
          flash[:success] = 'Pedido atualizado!'
          @new_bill = new_bill_receivable_path(budget: @budget.id, value: @budget.value_with_discount)
        else
          flash[:error] = 'Você não tem estoque para faturar o pedido'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Pedido atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'billed'
      if params[:status] == 'delivered'
        if @budget.stock_withdrawal(current_user.id)
          flash[:success] = 'Saída de estoque realizada'
        else
          flash[:error] = 'Ocorreu algum problema, verifique seu estoque!'
        end
      end
    end

    if params[:origin] == 'show'
      if @new_bill.present?
        redirect_to @new_bill
      else
        redirect_to @budget
      end
    end
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
    load_form_options
  end

  # GET /budgets/1/edit
  def edit
    load_form_options
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    @budget.employee = Client.find(@budget.client_id).employee

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, success: 'Pedido criado com sucesso.' }
        format.json { render :show, status: :created, location: @budget }
      else
        load_form_options
        format.html { render :new }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      budget_params[:employee_id] = Client.find(budget_params[:client_id]).employee.id
      if @budget.update(budget_params)
        format.html { redirect_to @budget, success: 'Pedido atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @budget }
      else
        load_form_options
        format.html { render :edit }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Pedido apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def find_product
    client_id = params[:client_id]
    price = 0

    product_custom = ProductCustom.where(client_id: client_id, product_id: params[:id])
    if product_custom.present?
      price = product_custom.first.value
    else
      @product = Product.find(params[:id])
      price = @product.price
    end

    authorize! :read, @product
    render json: price.round(2)
  end

  private

  def load_selected_filters
    query = params[:q] || {}
    @selected_client = Client.accessible_by(current_ability).find_by(id: query[:client_id_eq]) if query[:client_id_eq].present?
    @selected_employee = Employee.accessible_by(current_ability).find_by(id: query[:employee_id_eq]) if query[:employee_id_eq].present?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_budget
    @budget = Budget.find(params[:id])
  end

  def set_budget_product
    @budget_product = BudgetProduct.find(params[:id])
  end

  def load_form_options
    clients = Client.accessible_by(current_ability)
    client_ids = clients.order(:company_name).limit(50).pluck(:id)
    client_ids |= [@budget.client_id].compact
    @client_options = clients.where(id: client_ids).order(:company_name).map { |client| [client.company_name, client.id] }

    products = Product.accessible_by(current_ability)
    product_ids = products.order(:name).limit(50).pluck(:id)
    product_ids |= @budget.budget_products.map(&:product_id).compact
    @product_options = products.where(id: product_ids).order(:name).map do |product|
      ["#{product.cod} / #{product.name}", product.id]
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def budget_product_params
    params.require(:budget_product).permit(:reserve_qnt)
  end

  def budget_params
    params.require(:budget).permit! # (:name, :client_id, :employee_id, :value, :deadline, :delivery_options, :payment_term, :type_of_payment, :discount, :discount_type)
  end
end
