class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /transfers
  # GET /transfers.json
  def index
    @q = Transfer.ransack(params[:q])
    @transfers = @q.result.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.user = current_user

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to @transfer, notice: 'Transferência criada com sucesso.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    if @transfer.destroy
      flash[:notice] = 'Transferência apagada com sucesso.'
    else
      flash[:error] = @transfer.errors[:base].to_sentence
    end
    respond_to do |format|
      format.html { redirect_to transfers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:bank_receiver_id, :bank_id, :bank, :value, :obs)
    end
end
