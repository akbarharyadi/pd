class CreateWilayahs < ActiveRecord::Migration[5.0]
  def change
    create_table :wilayahs do |t|
      t.string :nama_wilayah
      t.string :jenis_wilayah
      t.string :pemimpin
      t.string :ibu_kota
      t.string :nama_badan
      t.string :alamat_badan
      t.string :telp_badan
      t.string :slug

      t.timestamps
    end
  end
end
