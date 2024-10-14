# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_user, :set_role, :set_navbar_variables, :set_links

  def authenticate_admin!
    return if @role == 'admin'

    redirect_to root_path, alert: 'You are not authorized.'
  end

  def authenticate_member!
    return if @role == 'admin' || @role == 'member' || @role == 'officer'

    redirect_to root_path,
                alert: 'You are not authorized, tell your higher-ups to make you a member'
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
    puts @role
  end

  def set_navbar_variables
    @nav_links = [
      { name: 'Home', path: root_path },
      { name: 'Events', path: events_path },
      { name: 'Photo Gallery', path: photos_path },
      { name: 'Leaderboard', path: leaderboard_categories_url },
      { name: 'Merchandise', path: merchandises_path },
      { name: 'Idea Board', path: ideas_path },
      { name: 'Member Management', path: users_path },
      { name: 'Links', path: links_path }
    ] || []

    links_to_reject = case @role
                      when 'admin'
                        []
                      when 'member'
                        ['members']
                      when 'officer'
                        ['members']
                      else
                        ['events', 'leaderboard', 'merch', 'ideas', 'members']
                      end

    @nav_links.reject! { |link| links_to_reject.include?(link[:name]) }

    @auth_link = if current_user
                   { name: 'Logout', path: destroy_user_session_path, method: :get }
                 else
                   { name: 'Login', path: user_google_oauth2_omniauth_authorize_path, method: :post }
                 end
  end

  def set_links
    @links = Link.all
  end
end
