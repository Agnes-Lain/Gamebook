class Console < ApplicationRecord
  has_many :games, through: :game_consoles
  has_many :user_consoles
end
