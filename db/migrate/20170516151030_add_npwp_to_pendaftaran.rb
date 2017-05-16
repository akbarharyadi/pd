class AddNpwpToPendaftaran < ActiveRecord::Migration[5.0]
  def change
    add_column :pendaftarans, :npwp, :string
  end
end
