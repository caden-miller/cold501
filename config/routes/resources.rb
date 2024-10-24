# frozen_string_literal: true

# config/routes/resources.rb
Rails.application.routes.draw do
  # Resource routes
  resources :ideas
  resources :merchandises, path: 'merch'
  resources :merch
  resources :links, except: [:show]
  resources :leaderboard_categories, path: 'leaderboard'
  resources :photos do
    member do
      get :delete
    end
    collection do
      get :gallery
    end
  end
end
