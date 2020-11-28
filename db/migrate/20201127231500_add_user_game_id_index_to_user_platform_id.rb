class AddUserGameIdIndexToUserPlatformId < ActiveRecord::Migration[6.0]
  def change
    add_index :user_game_user_platforms, [:user_game_id, :user_platform_id], unique: true, name: "user_platform_game_index"
  end
end
