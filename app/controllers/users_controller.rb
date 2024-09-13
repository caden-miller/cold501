class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:leaderboard]

  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User updated successfully.'
    else
      render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def leaderboard
    @users = User.order([:id])
  end

  private

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
