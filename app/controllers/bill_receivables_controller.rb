class BillReceivablesController < ApplicationController
  before_action :set_bill_receivable, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /bill_receivables
  # GET /bill_receivables.json
  def index
    @q = BillReceivable.ransack(params[:q])

    @bill_receivables = @q.result.accessible_by(current_ability).order(id: :desc).page params[:page]
    @modal_size = 'lg'

    # @bill_payables = @q.result.includes(:provider_contract, :category, :revenue, :bill_payable_installments).accessible_by(current_ability).order(id: :desc).page(params[:page])
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
        format.html { redirect_to @bill_receivable, notice: 'Bill receivable was successfully created.' }
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
        format.html { redirect_to @bill_receivable, notice: 'Bill receivable was successfully updated.' }
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
      format.html { redirect_to bill_receivables_url, notice: 'Bill receivable was successfully destroyed.' }
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
