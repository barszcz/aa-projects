Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show] do
    collection do
      get 'activate'
    end
  end


  resource :session, only: [:create, :new, :destroy]
  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: :new do
    resources :tracks, only: :new
  end

  resources :tracks, except: :new

  resources :notes, only: [:create, :destroy]

end
