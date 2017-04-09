class AddJumlahVolumeToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :jumlah_volume, :float
  end
end
