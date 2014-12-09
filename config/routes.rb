Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
  resource :session, only: [:new, :create, :destroy]
end
