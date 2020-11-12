class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.datetime :release_date
      t.string :studio
      t.string :description
      t.integer :age_limit
      t.boolean :is_online

      t.timestamps
    end
  end
end
