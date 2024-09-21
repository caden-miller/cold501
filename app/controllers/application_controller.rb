class ApplicationController < ActionController::Base
  before_action :set_user, :set_role, :set_navbar_variables
  
  def authenticate_admin!
    unless @role == 'admin'
      redirect_to root_path, alert: 'You are not authorized.'
    end
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
    puts "Current user role: #{@role}"
  end

  def set_navbar_variables
    @nav_links = [
      { name: 'Home', path: root_path },
      { name: 'Events', path: events_path },
      { name: 'Photo Gallery', path: photos_path },
      { name: 'Leaderboard', path: leaderboard_users_path },
      { name: 'Merchandise', path: merchandises_path },
      { name: 'Idea Board', path: ideas_path },
      { name: 'Member Management', path: users_path }
    ]

    links_to_reject = case @role 
                      when 'admin'
                        []
                      when 'member'
                        ['Member Management']
                      when 'officer'
                        ['Member Management']
                      else
                        ['Events', 'Leaderboard', 'Merchandise', 'Idea Board', 'Member Management']
                      end

    @nav_links.reject! { |link| links_to_reject.include?(link[:name]) }
  
    @auth_link = if current_user
                   { name: 'Logout', path: destroy_user_session_path, method: :delete }
                 else
                   { name: 'Login', path: new_user_session_path }
                 end
  end

end
