class AddAwesomeNestedSetToHabaneroVarieties < ActiveRecord::Migration
  def change
    add_column :habanero_varieties, :parent_id, :integer
    add_column :habanero_varieties, :lft, :integer
    add_column :habanero_varieties, :rgt, :integer
  end
end
