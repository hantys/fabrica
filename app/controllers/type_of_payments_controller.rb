class TypeOfPaymentsController < ApplicationController
  before_action :set_type_of_payment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /type_of_payments
  # GET /type_of_payments.json
  def index
    @type_of_payments = TypeOfPayment.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /type_of_payments/1
  # GET /type_of_payments/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /type_of_payments/new
  def new
    @type_of_payment = TypeOfPayment.new
  end

  # GET /type_of_payments/1/edit
  def edit
  end

  # POST /type_of_payments
  # POST /type_of_payments.json
  def create
    @type_of_payment = TypeOfPayment.new(type_of_payment_params)

    respond_to do |format|
      if @type_of_payment.save
        format.html { redirect_to @type_of_payment, notice: 'Item criado com sucesso.' }
        format.json { render :show, status: :created, location: @type_of_payment }
      else
        format.html { render :new }
        format.json { render json: @type_of_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_of_payments/1
  # PATCH/PUT /type_of_payments/1.json
  def update
    respond_to do |format|
      if @type_of_payment.update(type_of_payment_params)
        format.html { redirect_to @type_of_payment, notice: 'Item atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @type_of_payment }
      else
        format.html { render :edit }
        format.json { render json: @type_of_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_of_payments/1
  # DELETE /type_of_payments/1.json
  def destroy
    @type_of_payment.destroy
    respond_to do |format|
      format.html { redirect_to type_of_payments_url, notice: 'Item apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_of_payment
      @type_of_payment = TypeOfPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_of_payment_params
      params.require(:type_of_payment).permit!
    end
end
