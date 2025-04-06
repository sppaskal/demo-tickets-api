Rails.application.routes.draw do
  # Authentication routes
  post '/signup', to: 'auth#signup'
  post '/login', to: 'auth#login'

  resources :organizations do
    resources :events, only: [:index, :create, :update, :destroy]
  end

  resources :events, only: [:index, :show, :create] do
    post 'purchase_ticket', on: :member
  end
end
