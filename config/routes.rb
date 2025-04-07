Rails.application.routes.draw do
  get "seats/index"
  # Authentication routes
  post '/signup', to: 'auth#signup'
  post '/login', to: 'auth#login'

  resources :organizations do
    resources :events, only: [:index]
  end

  resources :events, only: [:index, :show, :create, :update, :destroy] do
    resources :seats, only: [:index]
  end

  resources :tickets, only: [:index, :create]
end
