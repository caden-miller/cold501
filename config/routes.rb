Rails.application.routes.draw do
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



end
