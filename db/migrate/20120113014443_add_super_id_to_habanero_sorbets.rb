class AddSuperIdToHabaneroSorbets < ActiveRecord::Migration
  def change
    add_column :habanero_sorbets, :super_id, :integer
  end
end
