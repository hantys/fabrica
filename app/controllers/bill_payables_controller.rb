class BillPayablesController < ApplicationController
  before_action :set_bill_payable, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /bill_payables
  # GET /bill_payables.json
  def index
    @q = BillPayable.ransack(params[:q])

    @bill_payables = @q.result.includes(:provider_contract, :category, :revenue).accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /bill_payables/1
  # GET /bill_payables/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /bill_payables/new
  def new
    @bill_payable = BillPayable.new
    @bill_payable.bill_payable_installments.build
  end

  # GET /bill_payables/1/edit
  def edit
  end

  # POST /bill_payables
  # POST /bill_payables.json
  def create
    @bill_payable = BillPayable.new(bill_payable_params)

    respond_to do |format|
      if @bill_payable.save
        format.html { redirect_to @bill_payable, notice: 'Bill payable was successfully created.' }
        format.json { render :show, status: :created, location: @bill_payable }
      else
        format.html { render :new }
        format.json { render json: @bill_payable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_payables/1
  # PATCH/PUT /bill_payables/1.json
  def update
    respond_to do |format|
      if @bill_payable.update(bill_payable_params)
        format.html { redirect_to @bill_payable, notice: 'Bill payable was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill_payable }
      else
        format.html { render :edit }
        format.json { render json: @bill_payable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_payables/1
  # DELETE /bill_payables/1.json
  def destroy
    @bill_payable.destroy
    respond_to do |format|
      format.html { redirect_to bill_payables_url, notice: 'Bill payable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_payable
      @bill_payable = BillPayable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_payable_params
      params.require(:bill_payable).permit!
    end
end
