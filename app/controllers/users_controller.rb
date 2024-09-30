# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :get_user, except: %i[index leaderboard]
  before_action :set_role, :set_navbar_variables
  before_action :authenticate_member!, only: [:leaderboard]
  before_action :authenticate_admin!, except: [:leaderboard]

  def index
    @users = User.order(:id)
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.turbo_stream # Responds to Turbo Stream requests
    end
  end

  def leaderboard
    @users = User.order(:id)
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :full_name,
      :committee,
      :points,
      :role,
      :dues
    )
  end
end
