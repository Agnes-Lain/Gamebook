class CreateUserConsoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_consoles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :console, null: false, foreign_key: true
      t.integer :rating
      t.datetime :buy_date

      t.timestamps
    end
  end
end
