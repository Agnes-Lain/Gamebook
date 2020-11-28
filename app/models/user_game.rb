class UserGame < ApplicationRecord
  # validates :user_id, uniquness: { scope: :rawg_game_id }

  belongs_to :user
  has_many :user_game_user_platforms
end
