Rails.application.routes.draw do
  resources :users
  resources :subs
  resource :session
end
