class CreatePendataans < ActiveRecord::Migration[5.0]
  def change
    create_table :pendataans do |t|
      t.date :tgl_data
      t.integer :tahun_spt
      t.integer :pendaftaran_id
      t.integer :rekening_id
      t.date :periode_awal
      t.date :periode_akhir
      t.float :omzet
      t.float :jumlah_pajak
      t.string :no_pendataan
      t.date :tgl_setor
      t.date :tgl_tetap
      t.integer :no_setor
      t.integer :no_kohir
      
      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
