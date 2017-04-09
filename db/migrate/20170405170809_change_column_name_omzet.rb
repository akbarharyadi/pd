class ChangeColumnNameOmzet < ActiveRecord::Migration[5.0]
  def change
    rename_column :pendataans, :omzet, :omzet
  end
end
