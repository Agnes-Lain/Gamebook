class AddGameNameToUserGames < ActiveRecord::Migration[6.0]
  def change
    add_column :user_games, :game_name, :string
  end
end
