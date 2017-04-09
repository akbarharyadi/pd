class CreateBidangs < ActiveRecord::Migration[5.0]
  def change
    create_table :bidangs do |t|
      t.string :kode_bidang
      t.string :nama_bidang

      t.column :deleted_at, :datetime, index: true
      t.column :slug, :string, index: true, unique: true
      t.column :created_by, :integer
      t.column :updated_by, :integer

      t.timestamps
    end
  end
end
