class CreateRekenings < ActiveRecord::Migration[5.0]
  def change
    create_table :rekenings do |t|
      t.string :kode
      t.string :jenis_kode
      t.string :turunan_kode
      t.string :nama_rekening
      t.integer :tahun
      t.float :tarif
      t.float :persen

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
