class CreateGolongans < ActiveRecord::Migration[5.0]
  def change
    create_table :golongans do |t|
      t.string :nama_pangkat
      t.string :golongan
      t.string :ruang

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
