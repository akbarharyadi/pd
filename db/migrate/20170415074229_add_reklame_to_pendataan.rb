class AddReklameToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :pajak_rokok, :integer
    add_column :pendataans, :nilai_reklame, :float
  end
end
