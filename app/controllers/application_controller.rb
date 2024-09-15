class ApplicationController < ActionController::Base
  before_action :set_user, :set_role
  
  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized.' unless @role == 'admin'
  end

  def authenticate_officer!
    redirect_to root_path, alert: 'You are not authorized.' unless @role == 'officer' || @role == 'admin'
  end

  def authenticate_user!
    redirect_to root_path, alert: 'Create an account by logging in with Google first.' unless @role == 'user' || @role == 'officer' || @role == 'admin'
  end

  private

  # set instance variable for user
  def set_user
    @user = current_user
  end

  # set instance variable for role
  def set_role
    @role = current_user&.role
  end
end
