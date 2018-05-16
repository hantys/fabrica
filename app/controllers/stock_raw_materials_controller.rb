class StockRawMaterialsController < ApplicationController
  before_action :set_stock_raw_material, only: [:show, :edit, :update, :destroy]

  # GET /stock_raw_materials
  # GET /stock_raw_materials.json
  def index
    @stock_raw_materials = StockRawMaterial.all
  end

  # GET /stock_raw_materials/1
  # GET /stock_raw_materials/1.json
  def show
  end

  # GET /stock_raw_materials/new
  def new
    @stock_raw_material = StockRawMaterial.new
  end

  # GET /stock_raw_materials/1/edit
  def edit
  end

  # POST /stock_raw_materials
  # POST /stock_raw_materials.json
  def create
    @stock_raw_material = StockRawMaterial.new(stock_raw_material_params)

    respond_to do |format|
      if @stock_raw_material.save
        format.html { redirect_to @stock_raw_material, notice: 'Stock raw material was successfully created.' }
        format.json { render :show, status: :created, location: @stock_raw_material }
      else
        format.html { render :new }
        format.json { render json: @stock_raw_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_raw_materials/1
  # PATCH/PUT /stock_raw_materials/1.json
  def update
    respond_to do |format|
      if @stock_raw_material.update(stock_raw_material_params)
        format.html { redirect_to @stock_raw_material, notice: 'Stock raw material was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_raw_material }
      else
        format.html { render :edit }
        format.json { render json: @stock_raw_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_raw_materials/1
  # DELETE /stock_raw_materials/1.json
  def destroy
    if @stock_raw_material.destroy
      flash[:notice] = 'Estoque apagado.'
    else
      flash[:error] = @stock_raw_material.errors[:base].to_sentence
    end
    respond_to do |format|
      format.html { redirect_to stock_raw_materials_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_raw_material
      @stock_raw_material = StockRawMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_raw_material_params
      params.require(:stock_raw_material).permit(:raw_material_id, :weight, :weight_out, :price)
    end
end
