class CreateUserGameUserPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_game_user_platforms do |t|
      t.references :user_platform, null: false, foreign_key: true
      t.references :user_game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
