class DeliveryOptionsController < ApplicationController
  before_action :set_delivery_option, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /delivery_options
  # GET /delivery_options.json
  def index
    @delivery_options = DeliveryOption.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /delivery_options/1
  # GET /delivery_options/1.json
  def show
  end

  # GET /delivery_options/new
  def new
    @delivery_option = DeliveryOption.new
  end

  # GET /delivery_options/1/edit
  def edit
  end

  # POST /delivery_options
  # POST /delivery_options.json
  def create
    @delivery_option = DeliveryOption.new(delivery_option_params)

    respond_to do |format|
      if @delivery_option.save
        format.html { redirect_to @delivery_option, notice: 'Item criado com sucesso.' }
        format.json { render :show, status: :created, location: @delivery_option }
      else
        format.html { render :new }
        format.json { render json: @delivery_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_options/1
  # PATCH/PUT /delivery_options/1.json
  def update
    respond_to do |format|
      if @delivery_option.update(delivery_option_params)
        format.html { redirect_to @delivery_option, notice: 'Item atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @delivery_option }
      else
        format.html { render :edit }
        format.json { render json: @delivery_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_options/1
  # DELETE /delivery_options/1.json
  def destroy
    @delivery_option.destroy
    respond_to do |format|
      format.html { redirect_to delivery_options_url, notice: 'Item apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_option
      @delivery_option = DeliveryOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_option_params
      params.require(:delivery_option).permit!
    end
end
