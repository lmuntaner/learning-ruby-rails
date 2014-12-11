Rails.application.routes.draw do
  resource :user do
    resources :subs, only: [:new, :create]
  end
  
  resource :session
  resources :subs, except: [:new, :create]
  
  resources :posts do
    resources :comments, only: [:new, :show]
    member do
      post '/upvote', to: "votes#upvote"
      post '/downvote', to: "votes#downvote"
    end
  end
  
  resources :comments, only: [:create] do
    member do
      post '/upvote', to: "votes#upvote"
      post '/downvote', to: "votes#downvote"
    end
  end
end