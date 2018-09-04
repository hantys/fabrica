class BillReceivablesController < ApplicationController
  before_action :set_bill_receivable, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /bill_receivables
  # GET /bill_receivables.json
  def index
    @q = BillReceivable.ransack(params[:q])

    @bill_receivables = @q.result.includes(:category, :revenue, :budget).accessible_by(current_ability).order(id: :desc).page params[:page]
    @modal_size = 'lg'

  end

  def receives
    @receives = BillReceivableInstallment.where(id: params[:receber])
    # render json: {receives: @receives.pluck(:id), count: @receives.size}
  end

  def receives_update
    receives = params[:receives]
    @receives = BillReceivableInstallment.update(receives.keys, receives.values)
    aux = true
    @receives.each do |e|
      if e.errors.present?
        aux = false
      end
    end
    if aux
      redirect_to bill_receivables_url, success: 'Parcelas pagas com sucesso.'
    else
      render :receives
    end
  end

  def receive_item
    @receive = BillReceivableInstallment.find(params[:item_id])
    @bill_receivable = @receive.bill_receivable
    if params[:modal] == 'true'
      @modal = true
      render :receive_item, layout: false
    end
  end

  def receive_item_update
    @receive = BillReceivableInstallment.find(params[:item_id])
    @bill_receivable = @receive.bill_receivable
    @modal = true
    @bill_receivable.update(bill_receivable_params)
  end

  # GET /bill_receivables/1
  # GET /bill_receivables/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /bill_receivables/new
  def new
    @bill_receivable = BillReceivable.new
    @bill_receivable.bill_receivable_installments.build
  end

  # GET /bill_receivables/1/edit
  def edit
  end

  # POST /bill_receivables
  # POST /bill_receivables.json
  def create
    @bill_receivable = BillReceivable.new(bill_receivable_params)

    respond_to do |format|
      if @bill_receivable.save
        format.html { redirect_to @bill_receivable, notice: 'Conta a receber criada com sucesso.' }
        format.json { render :show, status: :created, location: @bill_receivable }
      else
        format.html { render :new }
        format.json { render json: @bill_receivable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_receivables/1
  # PATCH/PUT /bill_receivables/1.json
  def update
    respond_to do |format|
      if @bill_receivable.update(bill_receivable_params)
        format.html { redirect_to @bill_receivable, notice: 'Conta a receber atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @bill_receivable }
      else
        format.html { render :edit }
        format.json { render json: @bill_receivable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_receivables/1
  # DELETE /bill_receivables/1.json
  def destroy
    @bill_receivable.destroy
    respond_to do |format|
      format.html { redirect_to bill_receivables_url, notice: 'Conta a receber apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_receivable
      @bill_receivable = BillReceivable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_receivable_params
      params.require(:bill_receivable).permit!
    end
end
