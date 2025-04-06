
Rails.application.routes.draw do
  root to: "home#index"
  get "home/index"
  # Authentication routes
  post '/signup', to: 'auth#signup'
  post '/login', to: 'auth#login'

  resources :organizations do
    resources :events, only: [:index, :create, :update, :destroy]
  end

  resources :events, only: [:index, :show, :create]

  resources :tickets, only: [:index, :create]
  
end
