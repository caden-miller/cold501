class LeaderboardCategoriesController < ApplicationController
  before_action :set_leaderboard_category, only: %i[ show edit update destroy ]

  # GET /leaderboard_categories or /leaderboard_categories.json
  def index
    @users = User.all
    @leaderboard_categories = LeaderboardCategory.all
  end

  # GET /leaderboard_categories/1 or /leaderboard_categories/1.json
  def show
  end

  # GET /leaderboard_categories/new
  def new
    @leaderboard_category = LeaderboardCategory.new
  end

  # GET /leaderboard_categories/1/edit
  def edit
  end

  # POST /leaderboard_categories or /leaderboard_categories.json
  def create
    @leaderboard_category = LeaderboardCategory.new(leaderboard_category_params)

    respond_to do |format|
      if @leaderboard_category.save
        format.html { redirect_to leaderboard_category_url(@leaderboard_category), notice: "Leaderboard category was successfully created." }
        format.json { render :show, status: :created, location: @leaderboard_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leaderboard_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaderboard_categories/1 or /leaderboard_categories/1.json
  def update
    respond_to do |format|
      if @leaderboard_category.update(leaderboard_category_params)
        format.html { redirect_to leaderboard_category_url(@leaderboard_category), notice: "Leaderboard category was successfully updated." }
        format.json { render :show, status: :ok, location: @leaderboard_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leaderboard_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaderboard_categories/1 or /leaderboard_categories/1.json
  def destroy
    @leaderboard_category.destroy

    respond_to do |format|
      format.html { redirect_to leaderboard_categories_url, notice: "Leaderboard category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard_category
      @leaderboard_category = LeaderboardCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leaderboard_category_params
      params.require(:leaderboard_category).permit(:category_name, :min_points, :color)
    end
end
