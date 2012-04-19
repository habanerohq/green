class AddAwesomeNestedSetToHabaneroTraits < ActiveRecord::Migration
  def change
    add_column :habanero_traits, :parent_id, :integer
    add_column :habanero_traits, :lft, :integer
    add_column :habanero_traits, :rgt, :integer
  end
end
