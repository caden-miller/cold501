# frozen_string_literal: true

# config/routes/events.rb
Rails.application.routes.draw do
  # Event routes
  resources :events do
    member do
      get 'archive'
      get 'unarchive'
    end
    collection do
      get 'archived'
    end
    resources :attendances, only: [:create]
  end
end
