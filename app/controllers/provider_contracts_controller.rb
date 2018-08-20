class ProviderContractsController < ApplicationController
  before_action :set_provider_contract, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /provider_contracts
  # GET /provider_contracts.json
  def index
    @q = ProviderContract.ransack(params[:q])

    @provider_contracts = @q.result.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /provider_contracts/1
  # GET /provider_contracts/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /provider_contracts/new
  def new
    @provider_contract = ProviderContract.new
  end

  # GET /provider_contracts/1/edit
  def edit
  end

  # POST /provider_contracts
  # POST /provider_contracts.json
  def create
    @provider_contract = ProviderContract.new(provider_contract_params)

    respond_to do |format|
      if @provider_contract.save
        format.html { redirect_to @provider_contract, notice: 'Provider contract was successfully created.' }
        format.json { render :show, status: :created, location: @provider_contract }
      else
        format.html { render :new }
        format.json { render json: @provider_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provider_contracts/1
  # PATCH/PUT /provider_contracts/1.json
  def update
    respond_to do |format|
      if @provider_contract.update(provider_contract_params)
        format.html { redirect_to @provider_contract, notice: 'Provider contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @provider_contract }
      else
        format.html { render :edit }
        format.json { render json: @provider_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_contracts/1
  # DELETE /provider_contracts/1.json
  def destroy
    @provider_contract.destroy
    respond_to do |format|
      format.html { redirect_to provider_contracts_url, notice: 'Provider contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider_contract
      @provider_contract = ProviderContract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_contract_params
      params.require(:provider_contract).permit(:name, :provider_id, :obs, :total_value, :partil_value, :staus)
    end
end
