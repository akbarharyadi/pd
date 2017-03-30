class CreatePendaftarans < ActiveRecord::Migration[5.0]
  def change
    create_table :pendaftarans do |t|
      t.string :no_pendaftaran
      t.string :nama_usaha
      t.string :alamat_usaha
      t.integer :kecamatan_id
      t.integer :kelurahan_id
      t.string :no_telp_usaha
      t.string :nama_pemilik
      t.string :alamat_pemilik
      t.string :no_telp_pemilik
      t.string :npwpd
      t.date :tgl_npwpd
      t.integer :usaha_id
      t.string :no_reg_pendaftaran
      t.date :tgl_daftar

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
