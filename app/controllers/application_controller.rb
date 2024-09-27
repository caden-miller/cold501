class ApplicationController < ActionController::Base
  before_action :set_user, :set_role, :set_navbar_variables, :set_links
  
  def authenticate_admin!
    unless @role == 'admin'
      redirect_to root_path, alert: 'You are not authorized.'
    end
  end

  def authenticate_member!
    redirect_to root_path, alert: 'You are not authorized, tell your higher-ups to make you a member' unless @role == 'admin' || @role == 'member' ||  @role == 'officer'
  end

  private

  # set instance variable for user
  def set_user
    @user = current_user
    set_role if @user
  end
  

  # set instance variable for role
  def set_role
    @role ||= current_user&.role || 'guest'
  end

  def set_navbar_variables
    @nav_links = [
      { name: 'Photos', path: photos_path },
      { name: 'Events', path: events_path },
      { name: 'Leaderboard', path: leaderboard_users_path },
      { name: 'Merch', path: merchandises_path },
      { name: 'Ideas', path: ideas_path },
      { name: 'Members', path: users_path },
      { name: 'Links', path: links_path }
    ] || []

    links_to_reject = case @role 
                      when 'admin'
                        []
                      when 'member'
                        ['Members']
                      when 'officer'
                        ['Members']
                      else
                        ['Events', 'Leaderboard', 'Merch', 'Idea Board', 'Members']
                      end

    @nav_links.reject! { |link| links_to_reject.include?(link[:name]) }
  
    @auth_link = if current_user
                   { name: 'Logout', path: destroy_user_session_path, method: :delete }
                 else
                   { name: 'Login', path: new_user_session_path }
                 end
  end

  def set_links
    @links = Link.all
  end
end
