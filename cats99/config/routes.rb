Rails.application.routes.draw do
  resource :user, only: [:show, :create, :new, :destroy] do
    resources :cats, except: [:index, :show]
  end
  
  resource :session, only: [:create, :new, :destroy]
  
  resources :cats, only: [:index, :show] do
    resources :cat_rental_requests, only: [:new, :create] do 
      #controller: ....
      member do  
        post "approve"
        post "deny"
      end
    end
  end
  
end