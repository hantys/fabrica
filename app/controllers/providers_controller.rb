# frozen_string_literal: true

class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /providers
  # GET /providers.json
  def index
    @q = Provider.ransack(params[:q])

    @providers = @q.result.includes(:state, :city).accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /providers/new
  def new
    @modal = false
    @provider = Provider.new
    if params[:modal] == 'true'
      @modal = true
      render :new, layout: false
    end
  end

  # GET /providers/1/edit
  def edit; end

  # POST /providers
  # POST /providers.json
  def create
    @modal = false
    @provider = Provider.new(provider_params)
    if params[:modal] == 'true'
      @modal = true
      @provider.save
    else
      respond_to do |format|
        if @provider.save
          format.html { redirect_to @provider, notice: 'Fornecedor criado com sucesso.' }
          format.json { render :show, status: :created, location: @provider }
        else
          format.html { render :new }
          format.json { render json: @provider.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'Fornecedor atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Fornecedor apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_provider
    @provider = Provider.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def provider_params
    params.require(:provider).permit(:company_name, :fantasy_name, :cpf, :cnpj, :street, :number, :neighborhood, :cep, :ie, :bank, :ag, :cc, :variation, :state_id, :city_id, :phone1, :phone2)
  end
end
