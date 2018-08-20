class CredCardsController < ApplicationController
  before_action :set_cred_card, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /cred_cards
  # GET /cred_cards.json
  def index
    @cred_cards = CredCard.all
  end

  # GET /cred_cards/1
  # GET /cred_cards/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /cred_cards/new
  def new
    @cred_card = CredCard.new
  end

  # GET /cred_cards/1/edit
  def edit
  end

  # POST /cred_cards
  # POST /cred_cards.json
  def create
    @cred_card = CredCard.new(cred_card_params)

    respond_to do |format|
      if @cred_card.save
        format.html { redirect_to @cred_card, notice: 'Cred card was successfully created.' }
        format.json { render :show, status: :created, location: @cred_card }
      else
        format.html { render :new }
        format.json { render json: @cred_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cred_cards/1
  # PATCH/PUT /cred_cards/1.json
  def update
    respond_to do |format|
      if @cred_card.update(cred_card_params)
        format.html { redirect_to @cred_card, notice: 'Cred card was successfully updated.' }
        format.json { render :show, status: :ok, location: @cred_card }
      else
        format.html { render :edit }
        format.json { render json: @cred_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cred_cards/1
  # DELETE /cred_cards/1.json
  def destroy
    @cred_card.destroy
    respond_to do |format|
      format.html { redirect_to cred_cards_url, notice: 'Cred card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cred_card
      @cred_card = CredCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cred_card_params
      params.require(:cred_card).permit(:name, :catd_final, :valid)
    end
end
