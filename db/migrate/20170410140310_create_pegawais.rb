class CreatePegawais < ActiveRecord::Migration[5.0]
  def change
    create_table :pegawais do |t|
      t.string :nama_pegawai
      t.string :nip
      t.integer :bidang_id
      t.integer :seksi_id
      t.integer :jabatan_id
      t.integer :golongan_id

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
