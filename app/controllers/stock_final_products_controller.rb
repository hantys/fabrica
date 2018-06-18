class StockFinalProductsController < ApplicationController
  before_action :set_stock_final_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /stock_final_products
  # GET /stock_final_products.json
  def index
    @stock_final_products = StockFinalProduct.includes(:product, hit: [:product]).accessible_by(current_ability).order(id: :desc)
  end

  # GET /stock_final_products/1
  # GET /stock_final_products/1.json
  def show
  end

  # GET /stock_final_products/new
  def new
    @stock_final_product = StockFinalProduct.new
  end

  # GET /stock_final_products/1/edit
  def edit
  end

  # POST /stock_final_products
  # POST /stock_final_products.json
  def create
    @stock_final_product = StockFinalProduct.new(stock_final_product_params)

    respond_to do |format|
      if @stock_final_product.save
        format.html { redirect_to @stock_final_product, notice: 'Entrada de estoque final criado com sucesso.' }
        format.json { render :show, status: :created, location: @stock_final_product }
      else
        format.html { render :new }
        format.json { render json: @stock_final_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_final_products/1
  # PATCH/PUT /stock_final_products/1.json
  def update
    respond_to do |format|
      if @stock_final_product.update(stock_final_product_params)
        format.html { redirect_to @stock_final_product, notice: 'Entrada de estoque final atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @stock_final_product }
      else
        format.html { render :edit }
        format.json { render json: @stock_final_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_final_products/1
  # DELETE /stock_final_products/1.json
  def destroy
    @stock_final_product.destroy
    respond_to do |format|
      format.html { redirect_to stock_final_products_url, notice: 'Entrada de estoque final apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_final_product
      @stock_final_product = StockFinalProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_final_product_params
      params.require(:stock_final_product).permit!
    end
end
