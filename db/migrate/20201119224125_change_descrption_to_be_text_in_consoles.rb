class ChangeDescrptionToBeTextInConsoles < ActiveRecord::Migration[6.0]
  def change
    change_column :consoles, :description, :text
  end
end
