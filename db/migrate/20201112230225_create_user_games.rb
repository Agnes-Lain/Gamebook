class CreateUserGames < ActiveRecord::Migration[6.0]
  def change
    create_table :user_games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :rating
      t.datetime :buy_date
      t.text :comments

      t.timestamps
    end
  end
end
