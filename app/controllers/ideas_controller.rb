# frozen_string_literal: true
include ActionView::RecordIdentifier

class IdeasController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_idea, only: %i[show edit update destroy]

  # GET /ideas or /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1 or /ideas/1.json
  def show; end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit; end

  # POST /ideas or /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user if current_user

    respond_to do |format|
      if @idea.save
        format.html { redirect_to idea_url(@idea), notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to idea_url(@idea), notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
# ideas_controller.rb
def destroy
  @idea = Idea.find(params[:id])
  @idea.destroy

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@idea)) }
    format.html { redirect_to ideas_path, notice: "Idea was successfully deleted." }
  end
end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def idea_params
    params.require(:idea).permit(:title, :description, :created_by, :created_at)
  end
end
