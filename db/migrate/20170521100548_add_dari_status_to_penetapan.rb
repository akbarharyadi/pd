class AddDariStatusToPenetapan < ActiveRecord::Migration[5.0]
  def change
    add_column :penetapans, :status, :integer
  end
end
