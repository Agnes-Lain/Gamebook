class AddRawgPlatformIdIndexToUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :user_platforms, [:user_id, :rawg_platform_id ], unique: true
  end
end
