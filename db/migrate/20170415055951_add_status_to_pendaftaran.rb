class AddStatusToPendaftaran < ActiveRecord::Migration[5.0]
  def change
    add_column :pendaftarans, :status, :integer
  end
end
