class AddColumnRawgIdToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :rawg_id, :integer
  end
end
