class AddColumnRawgIdToConsoles < ActiveRecord::Migration[6.0]
  def change
    add_column :consoles, :rawg_id, :integer
  end
end
