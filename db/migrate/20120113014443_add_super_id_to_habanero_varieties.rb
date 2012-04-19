class AddSuperIdToHabaneroVarieties < ActiveRecord::Migration
  def change
    add_column :habanero_varieties, :super_id, :integer
  end
end
