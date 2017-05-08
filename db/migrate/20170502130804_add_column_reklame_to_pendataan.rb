class AddColumnReklameToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :panjang_reklame, :float
    add_column :pendataans, :lebar_reklame, :float
    add_column :pendataans, :luas_reklame, :float
    add_column :pendataans, :jumlah_reklame, :float
    add_column :pendataans, :jumlah_hari_reklame, :float
    add_column :pendataans, :nilai_lokasi_reklame, :float
    add_column :pendataans, :sudut_pandang_reklame, :float
    add_column :pendataans, :tinggi_reklame, :float
    add_column :pendataans, :lokasi_reklame, :float
    add_column :pendataans, :judul_reklame, :float

    add_column :penetapans, :panjang_reklame, :float
    add_column :penetapans, :lebar_reklame, :float
    add_column :penetapans, :luas_reklame, :float
    add_column :penetapans, :jumlah_reklame, :float
    add_column :penetapans, :jumlah_hari_reklame, :float
    add_column :penetapans, :nilai_lokasi_reklame, :float
    add_column :penetapans, :sudut_pandang_reklame, :float
    add_column :penetapans, :tinggi_reklame, :float

    add_column :rekenings, :status, :integer
    add_column :rekenings, :satuan_masa_pajak, :string
  end
end
