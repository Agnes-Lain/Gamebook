class ChangeColumnNameToConsole < ActiveRecord::Migration[6.0]
  def change
    rename_column :consoles, :company, :description
  end
end
