class AddColumnReklameToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :panjang_reklame, :float
    add_column :pendataans, :lebar_reklame, :float
    add_column :pendataans, :luas_reklame, :float
    add_column :pendataans, :jumlah_reklame, :float
    add_column :pendataans, :sisi_muka_reklame, :float
    add_column :pendataans, :jumlah_hari_bulan_tahun_reklame, :float
    add_column :pendataans, :kelas_jalan_reklame, :float
    add_column :pendataans, :sudut_pandang_reklame, :float
    add_column :pendataans, :tinggi_reklame, :float
    add_column :pendataans, :lokasi_reklame, :float
    add_column :pendataans, :judul_reklame, :float

    add_column :penetapans, :panjang_reklame, :float
    add_column :penetapans, :lebar_reklame, :float
    add_column :penetapans, :luas_reklame, :float
    add_column :penetapans, :jumlah_reklame, :float
    add_column :penetapans, :sisi_muka_reklame, :float
    add_column :penetapans, :jumlah_hari_bulan_tahun_reklame, :float
    add_column :penetapans, :kelas_jalan_reklame, :float
    add_column :penetapans, :sudut_pandang_reklame, :float
    add_column :penetapans, :tinggi_reklame, :float
  end
end
