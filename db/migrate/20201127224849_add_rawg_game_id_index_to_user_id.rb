class AddRawgGameIdIndexToUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :user_games, [:user_id, :rawg_game_id ], unique: true
  end
end
