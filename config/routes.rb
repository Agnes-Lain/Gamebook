Rails.application.routes.draw do
  devise_for :users

  # namespace :user do
  #   root :to => "pages#dashboard"
  # end
  resources :users do
    resources :user_games, only: [:create, :update, :destroy]
    resources :user_consoles, only: [:create, :update, :destroy]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/user" => 'pages#dashboard', :as => :user_root
  resources :games, only:[ :create ] do
    resources :game_consoles, only: [:create]
    resources :game_genres, only: [:create]
  end

end
