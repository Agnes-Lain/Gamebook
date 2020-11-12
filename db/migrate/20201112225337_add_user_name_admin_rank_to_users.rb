class AddUserNameAdminRankToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string, null: false, default: ""
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :rank, :integer, default: 0
  end
end
