class UserPlatform < ApplicationRecord
  # validates :user_id, uniquness: { scope: :rawg_platform_id }

  belongs_to :user
  has_many :user_game_user_platforms
end
