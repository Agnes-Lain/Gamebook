Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :user_games, only: [:create, :update, :destroy]
    resources :user_platforms, only: [:create, :update, :destroy]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # when user logged in, redirect user to dashboard as user's root
  get "/user" => 'pages#dashboard', :as => :user_root

end
