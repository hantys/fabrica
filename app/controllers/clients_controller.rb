class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :set_client]
  load_and_authorize_resource
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.includes(:state, :city, :employee).accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Cliente criado com sucesso.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Cliente atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def create_product_customs
    @client.custom_products
    render json: @client.product_customs, except: [:client_id, :product_id, :deleted_at, :created_at, :updated_at], include: {product: {only: [:id, :cod, :name]}}
  end

  def list_product_customs
    render json: @client.product_customs, except: [:client_id, :product_id, :deleted_at, :created_at, :updated_at], include: {product: {only: [:id, :cod, :name]}}
  end

  def update_list_product_customs
    # @pays = BillPayableInstallment.update(pays.keys, pays.values)
    render json: params[:data]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:company_name, :fantasy_name, :cpf, :street, :number, :neighborhood, :cep, :cnpj, :ie, :state_id, :city_id, :phone1, :phone2, :employee_id)
    end
end
