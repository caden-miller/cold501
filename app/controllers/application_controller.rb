class ApplicationController < ActionController::Base
  before_action :set_user, :set_role
  
  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized.' unless @role == 'admin'
  end

  def authenticate_member!
    redirect_to root_path, alert: 'You are not authorized, tell your higher-ups to make you a member' unless @role == 'admin' || @role == 'member' ||  @role == 'officer'
  end

  def authenticate_officer!
    redirect_to root_path, alert: 'You are not authorized.' unless @role == 'admin' || @role == 'officer'
  end

  def authenticate_user!
    puts "User role: #{@role}"
    redirect_to root_path, alert: 'Create an account by logging in with Google first.' unless @role == 'admin' || @role == 'member' || @role == 'officer' || @role == 'user'
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
