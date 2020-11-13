class AddColumnRawgIdToGenres < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :rawg_id, :integer
  end
end
