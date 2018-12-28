class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy, :credit_or_debit, :credit_or_debit_update]
  load_and_authorize_resource

  # GET /banks
  # GET /banks.json
  def index
    @banks = Bank.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  def credit_or_debit
    @op_transaction = OpTransaction.new
  end
  
  def credit_or_debit_update
    @op_transaction = OpTransaction.new(bank_params[:op_transaction])
    @op_transaction.transactionable_type = 'User'
    @op_transaction.transactionable_id = current_user.id
    @op_transaction.action = 3
    @op_transaction.bank = @bank

    respond_to do |format|
      if @op_transaction.save
        format.html { redirect_to @bank, notice: 'Operação realizada com sucesso.' }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :credit_or_debit }
        format.json { render json: @op_transaction.errors, status: :unprocessable_entity }
      end
    end
  end  

  # GET /banks/1
  # GET /banks/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: 'Banco criado com sucesso.' }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :new }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to @bank, notice: 'Banco atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url, notice: 'Banco apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit!
    end
end
