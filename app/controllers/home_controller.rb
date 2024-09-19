class HomeController < ApplicationController
  def index
    @user = current_user
  end

  def admin_panel
    # Authorization logic (optional)
    unless current_user&.role == 'admin'
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
