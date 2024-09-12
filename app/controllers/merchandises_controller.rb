class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: %i[ show edit update destroy ]

  # GET /merchandises or /merchandises.json
  def index
    @merchandises = Merchandise.all
  end

  # GET /merchandises/1 or /merchandises/1.json
  def show
  end

  # GET /merchandises/new
  def new
    @merchandise = Merchandise.new
  end

  # GET /merchandises/1/edit
  def edit
  end

  # POST /merchandises or /merchandises.json
  def create
    @merchandise = Merchandise.new(merchandise_params)

    respond_to do |format|
      if @merchandise.save
        format.html { redirect_to merchandise_url(@merchandise), notice: "Merchandise was successfully created." }
        format.json { render :show, status: :created, location: @merchandise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @merchandise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchandises/1 or /merchandises/1.json
  def update
    respond_to do |format|
      if @merchandise.update(merchandise_params)
        format.html { redirect_to merchandise_url(@merchandise), notice: "Merchandise was successfully updated." }
        format.json { render :show, status: :ok, location: @merchandise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @merchandise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchandises/1 or /merchandises/1.json
  def destroy
    @merchandise.destroy

    respond_to do |format|
      format.html { redirect_to merchandises_url, notice: "Merchandise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchandise_params
      params.require(:merchandise).permit(:link, :title, :description, :image, :stock)
    end
end
