Rails.application.routes.draw do
  
  resource :user do
    member { get 'activate' }
  end
  resource :session
  
  resources :bands do
    resources :albums, only: :new
  end
  
  resources :albums, except: :new do
    resources :tracks, only: :new
  end
  
  resources :tracks, except: :new do
    resources :notes, only: [:create, :destroy]
  end
end