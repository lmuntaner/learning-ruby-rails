Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    member do
      get "favorites"
    end
    resources :comments, only: :index
    resources :groups, only: :index
    resources :contacts, only: :index
  end
  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :comments, only: :index
  end
  resources :contact_shares, only: [:create, :destroy]
  resources :groups, only: :show do
    member do
      get "contacts"
    end
  end
end