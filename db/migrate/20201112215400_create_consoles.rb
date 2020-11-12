class CreateConsoles < ActiveRecord::Migration[6.0]
  def change
    create_table :consoles do |t|
      t.string :console_model
      t.string :company
      t.integer :release_year

      t.timestamps
    end
  end
end
