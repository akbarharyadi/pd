class AddNamaSuratToTtd < ActiveRecord::Migration[5.0]
  def change
    add_column :ttds, :nama_surat, :string
  end
end
