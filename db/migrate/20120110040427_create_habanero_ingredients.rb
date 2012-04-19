class CreateHabaneroIngredients < ActiveRecord::Migration
  def change
    create_table :habanero_ingredients do |t|
      t.belongs_to :variety
    end
    add_index :habanero_ingredients, :variety_id
  end
end
