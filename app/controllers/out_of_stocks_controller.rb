class OutOfStocksController < ApplicationController
  before_action :set_out_of_stock, only: [:show, :edit, :update, :destroy]

  # GET /out_of_stocks
  # GET /out_of_stocks.json
  def index
    @out_of_stocks = OutOfStock.all
  end

  # GET /out_of_stocks/1
  # GET /out_of_stocks/1.json
  def show
    if params[:modal] == 'true'
      @modal = true
      render :show, layout: false
    end
  end

  # GET /out_of_stocks/new
  def new
    @out_of_stock = OutOfStock.new
  end

  # GET /out_of_stocks/1/edit
  def edit
  end

  # POST /out_of_stocks
  # POST /out_of_stocks.json
  def create
    @out_of_stock = OutOfStock.new(out_of_stock_params)

    respond_to do |format|
      if @out_of_stock.save
        format.html { redirect_to @out_of_stock, notice: 'Out of stock was successfully created.' }
        format.json { render :show, status: :created, location: @out_of_stock }
      else
        format.html { render :new }
        format.json { render json: @out_of_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /out_of_stocks/1
  # PATCH/PUT /out_of_stocks/1.json
  def update
    respond_to do |format|
      if @out_of_stock.update(out_of_stock_params)
        format.html { redirect_to @out_of_stock, notice: 'Out of stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @out_of_stock }
      else
        format.html { render :edit }
        format.json { render json: @out_of_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /out_of_stocks/1
  # DELETE /out_of_stocks/1.json
  def destroy
    @out_of_stock.destroy
    respond_to do |format|
      format.html { redirect_to out_of_stocks_url, notice: 'Out of stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_out_of_stock
      @out_of_stock = OutOfStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def out_of_stock_params
      params.require(:out_of_stock).permit(:budget_id, :user_id, :product_id, :qnt, :cost, :value)
    end
end
