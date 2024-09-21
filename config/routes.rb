Rails.application.routes.draw do

  resources :ideas
  resources :merchandises
  resources :merch
  resources :links, except: [:show]


  resources :events do   # Generates all routes for events (index, show, new, edit, create, update, destroy)
    member do
      get 'delete'
    end
  end

  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  resources :photos do 
    member do
      get :delete
    end
  end
  resources :home
  resources :users do
    member do
      get :delete
      get :show
    end

    collection do
      get 'leaderboard'
    end
  end
end
