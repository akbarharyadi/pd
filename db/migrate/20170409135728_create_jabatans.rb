class CreateJabatans < ActiveRecord::Migration[5.0]
  def change
    create_table :jabatans do |t|
      t.string :kode_jabatan
      t.string :nama_jabatan
      t.string :singkatan

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
