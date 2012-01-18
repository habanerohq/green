class AddAwesomeNestedSetToHabaneroIngredients < ActiveRecord::Migration
  def change
    add_column :habanero_ingredients, :parent_id, :integer
    add_column :habanero_ingredients, :lft, :integer
    add_column :habanero_ingredients, :rgt, :integer
  end
end
