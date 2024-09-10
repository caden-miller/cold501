class MerchesController < ApplicationController
  before_action :set_merch, only: %i[ show edit update destroy ]

  # GET /merches or /merches.json
  def index
    @merches = Merch.all
  end

  # GET /merches/1 or /merches/1.json
  def show
  end

  # GET /merches/new
  def new
    @merch = Merch.new
  end

  # GET /merches/1/edit
  def edit
  end

  # POST /merches or /merches.json
  def create
    @merch = Merch.new(merch_params)

    respond_to do |format|
      if @merch.save
        format.html { redirect_to merch_url(@merch), notice: "Merch was successfully created." }
        format.json { render :show, status: :created, location: @merch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @merch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merches/1 or /merches/1.json
  def update
    respond_to do |format|
      if @merch.update(merch_params)
        format.html { redirect_to merch_url(@merch), notice: "Merch was successfully updated." }
        format.json { render :show, status: :ok, location: @merch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @merch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merches/1 or /merches/1.json
  def destroy
    @merch.destroy

    respond_to do |format|
      format.html { redirect_to merches_url, notice: "Merch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merch
      @merch = Merch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merch_params
      params.require(:merch).permit(:link, :title, :description, :image, :stock)
    end
end
