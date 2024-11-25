# frozen_string_literal: true

# LeaderboardCategoriesController manages the creation, viewing, updating, and deletion of leaderboard categories.
class LeaderboardCategoriesController < ApplicationController
  before_action :authenticate_member!
  before_action :set_leaderboard_category, only: %i[show edit update destroy]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_users

  # GET /leaderboard_categories or /leaderboard_categories.json
  def index
    @leaderboard_categories = LeaderboardCategory.order(min_points: :desc)
  end

  # GET /leaderboard_categories/1 or /leaderboard_categories/1.json
  def show; end

  # GET /leaderboard_categories/new
  def new
    @leaderboard_category = LeaderboardCategory.new
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  # GET /leaderboard_categories/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(dom_id(@leaderboard_category),
                                                  partial: 'leaderboard_categories/form',
                                                  locals: { leaderboard_category: @leaderboard_category })
      end
      format.html
    end
  end

  # POST /leaderboard_categories or /leaderboard_categories.json
  def create
    @leaderboard_category = LeaderboardCategory.new(leaderboard_category_params)

    if @leaderboard_category.save
      broadcast_leaderboard_update
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
    broadcast_leaderboard_update
    respond_to do |format|
      format.html do
        redirect_to leaderboard_categories_path, notice: 'Leaderboard category was successfully destroyed.'
      end
      format.turbo_stream
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
    Rails.logger.debug 'Category Created'
    respond_to do |format|
      format.html { redirect_to leaderboard_categories_path, notice: 'Leaderboard category was successfully created.' }
      format.turbo_stream
    end
  end

  def handle_update_success
    respond_to do |format|
      format.html { redirect_to leaderboard_categories_path, notice: 'Leaderboard category was successfully updated.' }
      format.turbo_stream
    end
  end

  def handle_create_failure
    flash.now[:alert] = @leaderboard_category.errors.full_messages.to_sentence
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.turbo_stream { render :new, status: :unprocessable_entity }
    end
  end

  def handle_update_failure
    flash.now[:alert] = @leaderboard_category.errors.full_messages.to_sentence
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.turbo_stream { render :edit, status: :unprocessable_entity }
    end
  end

  def set_users
    @users = User.order(points: :desc, full_name: :asc)
  end

  def broadcast_leaderboard_update
    Turbo::StreamsChannel.broadcast_replace_to(
      'leaderboard',
      target: 'leaderboard',
      partial: 'leaderboard_categories/leaderboard',
      locals: { users: @users }
    )
  end
end
