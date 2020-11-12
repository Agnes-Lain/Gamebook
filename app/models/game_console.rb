class GameConsole < ApplicationRecord
  belongs_to :console
  belongs_to :game
end
