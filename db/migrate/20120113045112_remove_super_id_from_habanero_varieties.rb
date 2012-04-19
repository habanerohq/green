class RemoveSuperIdFromHabaneroVarieties < ActiveRecord::Migration
  def up
    remove_column :habanero_varieties, :super_id
  end

  def down
    add_column :habanero_varieties, :super_id, :integer
  end
end
