class AddSingkatanToWilayah < ActiveRecord::Migration[5.0]
  def change
    add_column :wilayahs, :singkatan, :string
    add_column :wilayahs, :fax, :string
    add_column :wilayahs, :kode_pos, :string
  end
end
