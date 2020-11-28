class UserPlatform < ApplicationRecord
  validates :user, uniqueness: { scope: :rawg_platform_id }

  belongs_to :user
  has_many :user_game_user_platforms, dependent: :destroy
  has_many :user_games, through: :user_game_user_platforms
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5], allow_nil: true }
end
