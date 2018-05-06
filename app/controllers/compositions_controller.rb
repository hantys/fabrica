class CompositionsController < ApplicationController
  before_action :set_composition, only: [:show, :edit, :update, :destroy]

  # GET /compositions
  # GET /compositions.json
  def index
    @compositions = Composition.all
  end

  # GET /compositions/1
  # GET /compositions/1.json
  def show
  end

  # GET /compositions/new
  def new
    @composition = Composition.new
  end

  # GET /compositions/1/edit
  def edit
  end

  def compositionals_or_compositions
    @kind = params[:kind]
    @composition = Composition.new
    render :layout => false
  end

  # POST /compositions
  # POST /compositions.json
  def create
    @composition = Composition.new(composition_params)

    respond_to do |format|
      if @composition.save
        format.html { redirect_to @composition, notice: 'Composition was successfully created.' }
        format.json { render :show, status: :created, location: @composition }
      else
        format.html { render :new }
        format.json { render json: @composition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compositions/1
  # PATCH/PUT /compositions/1.json
  def update
    respond_to do |format|
      if @composition.update(composition_params)
        format.html { redirect_to @composition, notice: 'Composition was successfully updated.' }
        format.json { render :show, status: :ok, location: @composition }
      else
        format.html { render :edit }
        format.json { render json: @composition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compositions/1
  # DELETE /compositions/1.json
  def destroy
    @composition.destroy
    respond_to do |format|
      format.html { redirect_to compositions_url, notice: 'Composition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_composition
      @composition = Composition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def composition_params
      params.require(:composition).permit!
    end
end
