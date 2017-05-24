class AddDariStatus2ToPenetapan < ActiveRecord::Migration[5.0]
  def change
    add_column :penetapans, :status2, :integer
  end
end
