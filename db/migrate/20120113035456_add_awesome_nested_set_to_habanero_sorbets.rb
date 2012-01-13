class AddAwesomeNestedSetToHabaneroSorbets < ActiveRecord::Migration
  def change
    add_column :habanero_sorbets, :parent_id, :integer
    add_column :habanero_sorbets, :lft, :integer
    add_column :habanero_sorbets, :rgt, :integer
  end
end
