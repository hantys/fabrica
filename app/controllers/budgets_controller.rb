class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]
  before_action :set_budget_product, only: [:reserve_product, :updated_reserve_product]
  load_and_authorize_resource except: [:find_product, :reserve_product, :updated_reserve_product]
  # GET /budgets
  # GET /budgets.json
  def index
    @q = Budget.ransack(params[:q])

    @budgets = @q.result.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
  end

  def budget_pdf
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

  def update_status
    @budget = Budget.find params[:id]
    if @budget.status == 'waiting'
      case params[:status]
      when 'confirm'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'confirm'
      case params[:status]
      when 'authorized'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'authorized'
      case params[:status]
      when 'billed'
        if @budget.billed_budget
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Você não tem estoque para faturar o pedido'
        end
      when 'rejected'
        if @budget.update status: params[:status].to_sym
          flash[:success] = 'Orçamento atualizado!'
        else
          flash[:error] = 'Ocorreu algum problema!'
        end
      end
    elsif @budget.status == 'billed'
      if 'delivered' == params[:status]
        if @budget.stock_withdrawal(current_user.id)
          flash[:success] = 'Saída de estoque realizada'
        else
          flash[:error] = 'Ocorreu algum problema, verifique seu estoque!'
        end
      end
    end
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    @budget.employee = Client.find(@budget.client_id).employee

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, success: 'Orçamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @budget }
      else
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
        format.html { redirect_to @budget, success: 'Orçamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @budget }
      else
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
      format.html { redirect_to budgets_url, notice: 'Orçamento apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def find_product
    @product = Product.find params[:id]
    authorize! :read, @product
    render json: @product.price.round(2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    def set_budget_product
      @budget_product = BudgetProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_product_params
      params.require(:budget_product).permit(:reserve_qnt)
    end

    def budget_params
      params.require(:budget).permit! #(:name, :client_id, :employee_id, :value, :deadline, :delivery_options, :payment_term, :type_of_payment, :discount, :discount_type)
    end
end
