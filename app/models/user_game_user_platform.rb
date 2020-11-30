class UserGameUserPlatform < ApplicationRecord
  validates :user_game_id, uniqueness: { scope: :user_platform_id, message: "Same game can be add only once to one platform" }
  belongs_to :user_platform
  belongs_to :user_game
end
