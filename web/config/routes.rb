El7a2ny::Application.routes.draw do
  #Frontend
  get 'auth/:provider/callback', to: 'sessions#create_facebook'
  get 'auth/failure', to: redirect('/')
  #get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create,:destroy]  
  resources :users, except: [:index, :destroy] do
  	member do
  		get :show_other_user
  		get :other_users
  		get :my_friends
  		get :pending_friends
  		get :requested_friends
  		get :users_friends
      get :my_offers
      get :my_friends_offers
      get :my_notifications
  		resources :offers do
        member do
          get :private_list
          get :offer_members
        end  
      end 
  	end	
  end	
  resources :notifications, only: :destroy
  resources :invitations, only: [:create, :destroy]
  resources :comments, only: [:create,:update, :destroy]
  resources :replies, only: [:create, :destroy]
  resources :friendships, only: [:create,:destroy,:update] 
  root 'static_pages#home'  
  
  # API
  namespace :api, defaults: { format: :json } do
    get 'auth/:provider/callback', to: 'sessions#create_facebook'
    get 'auth/failure', to: redirect('/')
    #get 'signout', to: 'sessions#destroy', as: 'signout'
    resources :sessions, only: [:create,:destroy]  
    resources :users, except: [:index, :destroy] do
      member do
        get :show_other_user
        get :other_users
        get :my_friends
        get :pending_friends
        get :requested_friends
        get :users_friends
        get :my_offers
        get :my_friends_offers
        get :my_notifications
        resources :offers do
          member do
            get :private_list
            get :offer_members
          end  
        end 
      end 
    end 
    resources :notifications, only: :destroy
    resources :invitations, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :replies, only: [:create, :destroy]
    resources :friendships, only: [:create,:destroy,:update] 
    root 'static_pages#home'  
  end
end
