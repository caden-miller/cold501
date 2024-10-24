# frozen_string_literal: true

module Users
  # The Users::SessionsController class is responsible for handling user sessions.
  class SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource_or_scope)
      root_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end
  end
end
