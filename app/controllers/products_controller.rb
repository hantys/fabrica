class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /products
  # GET /products.json
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.accessible_by(current_ability).includes(:category_product).order(id: :desc).page params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  def product_cod
    @product = Product.find_by_cod(params[:cod])
    @modal = true
    render :show, layout: false
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    params[:product][:price] = params[:product][:price].gsub('.', '').gsub(',', '.').to_f
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Produto criado com sucesso.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    # params[:product][:price] = params[:product][:price].gsub('.', '').gsub(',', '.').to_f
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Produto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Produto apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:cod, :name, :price, :weight, :qnt, :derivative)
    end
end
