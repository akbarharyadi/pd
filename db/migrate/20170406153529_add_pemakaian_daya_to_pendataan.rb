class AddPemakaianDayaToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :pemakaian_daya, :float
    add_column :pendataans, :volume_pemakaian, :float
  end
end
