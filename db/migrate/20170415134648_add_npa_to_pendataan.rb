class AddNpaToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :npa, :float
  end
end
