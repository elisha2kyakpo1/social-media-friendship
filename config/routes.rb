Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do 
    member do 
      get 'create_friendship'
      get 'delete_friends'
      get 'confirm_friends'
    end 
  end 
    
  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create, :index]
    resources :likes, only: [:create, :destroy]    
  end

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_for :users
      resources :posts, only: [:index] do
        resources :comments, only: [:create]
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
