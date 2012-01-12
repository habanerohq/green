class AddNameToHabaneroIngredients < ActiveRecord::Migration
  def change
    add_column :habanero_ingredients, :name, :string
  end
end
