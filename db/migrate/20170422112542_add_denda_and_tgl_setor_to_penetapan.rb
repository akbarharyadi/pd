class AddDendaAndTglSetorToPenetapan < ActiveRecord::Migration[5.0]
  def change
    add_column :penetapans, :denda, :float
    add_column :penetapans, :tgl_setor, :date
  end
end
