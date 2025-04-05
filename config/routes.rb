Rails.application.routes.draw do
  resources :organizations do
    resources :events, only: [:index, :create, :update, :destroy]
  end

  resources :events, only: [:index, :show] do
    post 'purchase_ticket', on: :member
  end
end
