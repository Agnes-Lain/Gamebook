class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # acts_as_token_authenticatable

  has_many :user_platforms, dependent: :destroy
  has_many :user_games, dependent: :destroy
  has_many :user_game_user_platforms, through: :user_games, dependent: :destroy
  has_one_attached :photo
end
