class AddPlatformNameToUserPlatforms < ActiveRecord::Migration[6.0]
  def change
    add_column :user_platforms, :platform_name, :string
  end
end
