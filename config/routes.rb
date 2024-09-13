Rails.application.routes.draw do
<<<<<<< HEAD
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # For OAuth
  get '/auth/:provider/callback' => 'sessions#omniauth'


  # Defines the root path route ("/")
  root "home#index"
  resources :events do   # Generates all routes for events (index, show, new, edit, create, update, destroy)
    member do
      get 'delete'
    end
  end

=======
  root to: 'home#index'
>>>>>>> dev

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  resources :home
  resources :users do
    member do
      get :delete
    end

    collection do
      get 'leaderboard'
    end
  end
end
