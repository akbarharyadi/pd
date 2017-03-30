class CreateKelurahans < ActiveRecord::Migration[5.0]
  def change
    create_table :kelurahans do |t|
      t.string :kode, limit: 3
      t.string :nama, limit: 50
      t.integer :kecamatan_id
      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end
end
