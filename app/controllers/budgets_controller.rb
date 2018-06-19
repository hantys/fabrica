class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:find_product]
  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = Budget.accessible_by(current_ability).order(id: :desc)
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
  end

  def budget_pdf
    @budget = Budget.find params[:id]
  end

  def update_status
    @budget = Budget.find params[:id]
    if @budget.status == 'waiting'
      case params[:status]
      when 'authorized'
        @budget.update status: params[:status].to_sym
      when 'rejected'
        @budget.update status: params[:status].to_sym
      end
    elsif @budget.status == 'authorized'
      case params[:status]
      when 'billed'
        @budget.update status: params[:status].to_sym
      end
    elsif @budget.status == 'billed'
      case params[:status]
      when 'delivered'
        @budget.update status: params[:status].to_sym
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
        format.html { redirect_to @budget, notice: 'Orçamento criado com sucesso.' }
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
        format.html { redirect_to @budget, notice: 'Orçamento atualizado com sucesso.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      params.require(:budget).permit! #(:name, :client_id, :employee_id, :value, :deadline, :delivery_options, :payment_term, :type_of_payment, :discount, :discount_type)
    end
end
