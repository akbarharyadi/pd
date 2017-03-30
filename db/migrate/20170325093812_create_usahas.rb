class CreateUsahas < ActiveRecord::Migration[5.0]
  def change
    create_table :usahas do |t|
      t.string :kode_usaha, limit: 2
      t.string :nama_usaha

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
