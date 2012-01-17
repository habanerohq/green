class AddTypeToHabaneroIngredients < ActiveRecord::Migration
  def change
    add_column :habanero_ingredients, :type, :string
  end
end
