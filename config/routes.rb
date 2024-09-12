Rails.application.routes.draw do
  resources :ideas
  resources :merchandises
  resources :merch
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # For OAuth
  get '/auth/:provider/callback' => 'sessions#omniauth'


  # Defines the root path route ("/")
  root "home#index"


end
