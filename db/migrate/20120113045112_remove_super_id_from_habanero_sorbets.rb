class RemoveSuperIdFromHabaneroSorbets < ActiveRecord::Migration
  def up
    remove_column :habanero_sorbets, :super_id
  end

  def down
    add_column :habanero_sorbets, :super_id, :integer
  end
end
