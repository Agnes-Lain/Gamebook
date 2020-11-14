class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_consoles
  has_many :user_games
  has_many :consoles, through: :user_consoles
  has_many :games, through: :user_games
  has_one_attached :photo
end
