# frozen_string_literal: true

Rails.application.routes.draw do
  # Root route
  root to: 'home#index'

  # Load routes from separate route files
  draw :devise
  draw :users
  draw :resources
  draw :events

  # Home routes
  get 'support' => 'home#support', as: :support

end
