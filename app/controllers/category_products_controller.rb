class CategoryProductsController < ApplicationController
  before_action :set_category_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /category_products
  # GET /category_products.json
  def index
    @category_products = CategoryProduct.accessible_by(current_ability).order(id: :desc).page params[:page]
  end

  # GET /category_products/1
  # GET /category_products/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /category_products/new
  def new
    @category_product = CategoryProduct.new
  end

  # GET /category_products/1/edit
  def edit
  end

  # POST /category_products
  # POST /category_products.json
  def create
    @category_product = CategoryProduct.new(category_product_params)

    respond_to do |format|
      if @category_product.save
        format.html { redirect_to @category_product, notice: 'Categoria do produto criada com  sucesso.' }
        format.json { render :show, status: :created, location: @category_product }
      else
        format.html { render :new }
        format.json { render json: @category_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_products/1
  # PATCH/PUT /category_products/1.json
  def update
    respond_to do |format|
      if @category_product.update(category_product_params)
        format.html { redirect_to @category_product, notice: 'Categoria do produto atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @category_product }
      else
        format.html { render :edit }
        format.json { render json: @category_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_products/1
  # DELETE /category_products/1.json
  def destroy
    @category_product.destroy
    respond_to do |format|
      format.html { redirect_to category_products_url, notice: 'Categoria do produto apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_product
      @category_product = CategoryProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_product_params
      params.require(:category_product).permit(:name)
    end
end
