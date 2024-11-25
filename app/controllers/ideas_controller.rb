# frozen_string_literal: true

# Controller for managing Idea resources, including CRUD operations.
class IdeasController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_idea, only: %i[show edit update destroy]
  before_action :authenticate_user! # Ensure the user is authenticated

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
        handle_successful_create(format)
      else
        handle_failed_create(format)
      end
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        handle_successful_update(format)
      else
        handle_failed_update(format)
      end
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@idea)) }
      format.html { redirect_to ideas_path, notice: 'Idea was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Set the @idea instance variable based on the provided ID.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Strong parameters to prevent mass assignment vulnerabilities.
  def idea_params
    params.require(:idea).permit(:title, :description, :created_by)
  end

  # Handle successful creation of an idea.
  def handle_successful_create(format)
    format.html { redirect_to ideas_path, notice: 'Idea was successfully created.' }
    format.json { render :show, status: :created, location: @idea }
    format.turbo_stream do
      render turbo_stream: turbo_stream.append('ideas', partial: 'ideas/idea', locals: { idea: @idea })
    end
  end

  # Handle failed creation of an idea.
  def handle_failed_create(format)
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: @idea.errors, status: :unprocessable_entity }
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(dom_id(@idea), partial: 'ideas/form', locals: { idea: @idea })
    end
  end

  # Handle successful update of an idea.
  def handle_successful_update(format)
    format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
    format.json { render :show, status: :ok, location: @idea }
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(dom_id(@idea), partial: 'ideas/idea', locals: { idea: @idea })
    end
  end

  # Handle failed update of an idea.
  def handle_failed_update(format)
    format.html { render :edit, status: :unprocessable_entity }
    format.json { render json: @idea.errors, status: :unprocessable_entity }
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(dom_id(@idea), partial: 'ideas/form', locals: { idea: @idea })
    end
  end
end
