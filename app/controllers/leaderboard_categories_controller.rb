# frozen_string_literal: true

# LeaderboardCategoriesController manages the creation, viewing, updating, and deletion of leaderboard categories.
class LeaderboardCategoriesController < ApplicationController
  before_action :authenticate_member!
  before_action :set_leaderboard_category, only: %i[show edit update destroy]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]

  # GET /leaderboard_categories or /leaderboard_categories.json
  def index
    @users = User.order(points: :desc, full_name: :asc)
    @leaderboard_categories = LeaderboardCategory.all
  end

  # GET /leaderboard_categories/1 or /leaderboard_categories/1.json
  def show; end

  # GET /leaderboard_categories/new
  def new
    @leaderboard_category = LeaderboardCategory.new
  end

  # GET /leaderboard_categories/1/edit
  def edit; end

  # POST /leaderboard_categories or /leaderboard_categories.json
  def create
    @leaderboard_category = LeaderboardCategory.new(leaderboard_category_params)

    if @leaderboard_category.save
      handle_create_success
    else
      handle_create_failure
    end
  end

  # PATCH/PUT /leaderboard_categories/1 or /leaderboard_categories/1.json
  def update
    if @leaderboard_category.update(leaderboard_category_params)
      handle_update_success
    else
      handle_update_failure
    end
  end

  # DELETE /leaderboard_categories/1 or /leaderboard_categories/1.json
  def destroy
    @leaderboard_category.destroy

    respond_to do |format|
      format.html { redirect_to leaderboard_categories_url, notice: 'Leaderboard category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_leaderboard_category
    @leaderboard_category = LeaderboardCategory.find(params[:id])
  end

  def leaderboard_category_params
    params.require(:leaderboard_category).permit(:category_name, :min_points, :color)
  end

  def handle_create_success
    respond_to do |format|
      format.html do
        redirect_to leaderboard_category_url(@leaderboard_category),
                    notice: 'Leaderboard category was successfully created.'
      end
      format.json { render :show, status: :created, location: @leaderboard_category }
    end
  end

  def handle_create_failure
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @leaderboard_category.errors, status: :unprocessable_entity }
    end
  end

  def handle_update_success
    respond_to do |format|
      format.html do
        redirect_to leaderboard_category_url(@leaderboard_category),
                    notice: 'Leaderboard category was successfully updated.'
      end
      format.json { render :show, status: :ok, location: @leaderboard_category }
    end
  end

  def handle_update_failure
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @leaderboard_category.errors, status: :unprocessable_entity }
    end
  end
end
