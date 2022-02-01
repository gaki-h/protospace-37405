Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  root to: "prototypes#index"
  root  'users#index'
  resources :users, only: [:new, :edit, :update, :show]
  resources :prototypes do
    resources :comments, only: :create
  end
end
