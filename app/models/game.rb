class Game < ApplicationRecord
  has_many :game_genres
  has_many :user_games
  has_many :game_consoles
  has_many :consoles, through: :game_consoles
  has_many :genres, through: :game_genres
end
