# frozen_string_literal: true

class AnnoucementsController < ApplicationController
  before_action :set_annoucement, only: %i[show edit update destroy]

  # GET /annoucements or /annoucements.json
  def index
    @annoucements = Annoucement.all
  end

  # GET /annoucements/1 or /annoucements/1.json
  def show; end

  # GET /annoucements/new
  def new
    @annoucement = Annoucement.new
  end

  # GET /annoucements/1/edit
  def edit; end

  # POST /annoucements or /annoucements.json
  def create
    @annoucement = Annoucement.new(annoucement_params)

    respond_to do |format|
      if @annoucement.save
        format.html { redirect_to annoucement_url(@annoucement), notice: 'Annoucement was successfully created.' }
        format.json { render :show, status: :created, location: @annoucement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @annoucement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annoucements/1 or /annoucements/1.json
  def update
    respond_to do |format|
      if @annoucement.update(annoucement_params)
        format.html { redirect_to annoucement_url(@annoucement), notice: 'Annoucement was successfully updated.' }
        format.json { render :show, status: :ok, location: @annoucement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @annoucement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annoucements/1 or /annoucements/1.json
  def destroy
    @annoucement.destroy

    respond_to do |format|
      format.html { redirect_to annoucements_url, notice: 'Annoucement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_annoucement
    @annoucement = Annoucement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def annoucement_params
    params.require(:annoucement).permit(:title, :description, :created_by)
  end
end
