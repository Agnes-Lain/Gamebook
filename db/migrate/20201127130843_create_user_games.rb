class CreateUserGames < ActiveRecord::Migration[6.0]
  def change
    create_table :user_games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rawg_game_id
      t.integer :rating
      t.text :comments

      t.timestamps
    end
  end
end
