Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :user_games, only: [:index, :create]
    resources :user_platforms, only: [:create]
    member do
      post :add_friend
      post :un_friend
    end
  end

  resources :user_game_user_platforms, only: [:create]

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # when user logged in, redirect user to dashboard as user's root
  get "/user" => 'pages#dashboard', :as => :user_root

  resources :chatrooms, only: [:create] do
    resources :messages, only: :create
    resources :chatroom_users, only: :create
  end

  get 'games/:id', to: 'games#show', as: :game


end
