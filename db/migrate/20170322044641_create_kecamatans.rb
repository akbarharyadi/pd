class CreateKecamatans < ActiveRecord::Migration[5.0]
  def change
    create_table :kecamatans do |t|
      t.column :kode, :string, limit: 3
      t.column :nama, :string, null: true, limit: 50
      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer
      t.timestamps
    end
  end
end
