class AddStatusToPendataan < ActiveRecord::Migration[5.0]
  def change
    add_column :pendataans, :status, :integer
  end
end
