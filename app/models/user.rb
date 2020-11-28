class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_platforms
  has_many :user_games
  has_many :user_game_user_platforms, through: :user_games
  has_one_attached :photo
end
