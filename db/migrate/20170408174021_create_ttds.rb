class CreateTtds < ActiveRecord::Migration[5.0]
  def change
    create_table :ttds do |t|
      t.string :baris1
      t.string :baris2
      t.string :baris3
      t.integer :pegawai_id
      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end
end
