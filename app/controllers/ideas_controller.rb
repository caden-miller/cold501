# frozen_string_literal: true

# IdeasController manages the creation, viewing, editing, and deletion of ideas.
class IdeasController < ApplicationController
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
    @idea = build_idea

    if @idea.save
      handle_successful_create
    else
      handle_failed_create
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    if @idea.update(idea_params)
      handle_successful_update
    else
      handle_failed_update
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
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
