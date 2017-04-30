class CreatePenetapans < ActiveRecord::Migration[5.0]
  def change
    create_table :penetapans do |t|
      t.integer :no_tetap
      t.date :tgl_tetap
      t.integer :no_setor
      t.date :tgl_tetap
      t.integer :pendataan_id

      t.float :pemakaian_daya_teliti
      t.float :volume_pemakaian_teliti
      t.float :jumlah_volume_teliti
      t.integer :pajak_rokok_teliti
      t.float :nilai_reklame_teliti
      t.float :npa_teliti
      t.float :omzet_teliti
      t.float :jumlah_pajak_teliti

      t.timestamps
    end
  end
end
