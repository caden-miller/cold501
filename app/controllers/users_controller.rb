class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :delete]
  before_action :set_role
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:leaderboard]

  def index
    @users = User.order(:id)
  end

  def show    
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def delete
  end


  def destroy
    @user.destroy
    flash[:success] = "User was successfully deleted."
  end

  def leaderboard
    @users = User.order(:id)
  end

  private

  def set_user 
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
