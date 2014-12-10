Rails.application.routes.draw do
  resources :users
  resources :goals do
    member do
      patch 'complete'
    end
  end
  resource :session
end
