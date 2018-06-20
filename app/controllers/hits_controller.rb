class HitsController < ApplicationController
  before_action :set_hit, only: [:show, :edit, :update, :destroy]
  # GET /hits
  # GET /hits.json
  def index
    @hits = Hit.includes(:composition).accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /hits/1
  # GET /hits/1.json
  def show
  end

  # GET /hits/new
  def new
    @hit = Hit.new
  end

  # GET /hits/1/edit
  def edit
  end

  # POST /hits
  # POST /hits.json
  def create
    @hit = Hit.new(hit_params)

    respond_to do |format|
      if @hit.save
        format.html { redirect_to @hit, notice: 'Batida criado com sucesso.' }
        format.json { render :show, status: :created, location: @hit }
      else
        format.html { render :new }
        format.json { render json: @hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hits/1
  # PATCH/PUT /hits/1.json
  def update
    respond_to do |format|
      if @hit.update(hit_params)
        format.html { redirect_to @hit, notice: 'Batida atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @hit }
      else
        format.html { render :edit }
        format.json { render json: @hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hits/1
  # DELETE /hits/1.json
  def destroy
    if @hit.destroy
      flash[:notice] = 'Batida apagada com sucesso.'
    else
      flash[:error] = @hit.errors[:base].to_sentence
    end
    respond_to do |format|
      format.html { redirect_to hits_url }
      format.json { head :no_content }
    end
  end

  def load_items
    composition = Composition.find params[:composition]
    @raw_materials = composition.raw_materials
    respond_to { |format| format.js }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hit
      @hit = Hit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hit_params
      params.require(:hit).permit(:name, :product_id, :composition_id, :residue, hit_items_attributes: [:raw_material_id, :weight])
    end
end