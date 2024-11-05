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
  
    if @idea.save
      redirect_to ideas_path, notice: 'Idea was successfully created.' # Redirect directly to index on success
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  
  

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to idea_url(@idea), notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@idea), partial: "ideas/idea", locals: { idea: @idea }) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@idea), partial: "ideas/idea", locals: { idea: @idea }), status: :unprocessable_entity }
      end
    end
  end
  
  
  

  # DELETE /ideas/1 or /ideas/1.json
# ideas_controller.rb
def destroy
  @idea = Idea.find(params[:id])
  @idea.destroy

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.remove(@idea) }
    format.html { redirect_to ideas_path, notice: "Idea was successfully deleted." }
  end
end




  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :created_by, :created_at)
  end

  def build_idea
    idea = Idea.new(idea_params)
    idea.user = current_user.id if current_user
    idea
  end

  def handle_successful_create
    respond_to do |format|
      format.html { redirect_to idea_url(@idea), notice: 'Idea was successfully created.' }
      format.json { render :show, status: :created, location: @idea }
    end
  end

  def handle_failed_create
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @idea.errors, status: :unprocessable_entity }
    end
  end

  def handle_successful_update
    respond_to do |format|
      format.html { redirect_to idea_url(@idea), notice: 'Idea was successfully updated.' }
      format.json { render :show, status: :ok, location: @idea }
    end
  end

  def handle_failed_update
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @idea.errors, status: :unprocessable_entity }
    end
  end
end
