class ChangeColumnInPendataans < ActiveRecord::Migration[5.0]
  def change
    change_column :pendataans, :judul_reklame, :string
    change_column :pendataans, :lokasi_reklame, :text
  end
end
