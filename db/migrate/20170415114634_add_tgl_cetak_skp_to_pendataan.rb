class AddTglCetakSkpToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :denda, :float
    add_column :pendataans, :tgl_cetak_skp, :date
  end
end
