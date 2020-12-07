Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :user_games, only: [:create]
    resources :user_platforms, only: [:create]
    resources :chatrooms, only: [:create] do
      resources :message, only: :create
    end
    member do
      post :add_friend
      post :un_friend
    end
  end

  resources :user_game_user_platforms, only: [:create]
  resources :chatroom_users, only: [:create]

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # when user logged in, redirect user to dashboard as user's root
  get "/user" => 'pages#dashboard', :as => :user_root

end
