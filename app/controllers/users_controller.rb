# frozen_string_literal: true

# UsersController handles CRUD operations for users, including leaderboard management and point resets.
class UsersController < ApplicationController
  before_action :find_user, except: %i[index leaderboard reset_points]
  before_action :role, :set_navbar_variables
  before_action :authenticate_member!, only: [:leaderboard]
  before_action :authenticate_admin!, except: [:leaderboard]

  def index
    @users = User.order(:id)
  end

  def show; end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @user.update(user_params)
      handle_update_success
    else
      handle_update_failure
    end
  end

  def delete; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully deleted.' }
      format.turbo_stream
    end
  end

  def leaderboard
    @users = User.order(:id)
  end

  def reset_points
    User.find_each { |user| user.update(points: 0) } # Ensures validations are respected
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :committee, :points, :role, :dues)
  end

  def handle_update_success
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to users_path, notice: 'User was successfully updated.' }
    end
  end

  def handle_update_failure
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("user_#{@user.id}", partial: 'form', locals: { user: @user })
      end
      format.html { render :edit, status: :unprocessable_entity }
    end
  end
end
