class CreateSeksis < ActiveRecord::Migration[5.0]
  def change
    create_table :seksis do |t|
      t.string :kode_seksi
      t.string :nama_seksi
      t.string :singkatan
      t.integer :bidang_id

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
