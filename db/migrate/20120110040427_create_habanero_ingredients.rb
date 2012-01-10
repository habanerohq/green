class CreateHabaneroIngredients < ActiveRecord::Migration
  def change
    create_table :habanero_ingredients do |t|
      t.belongs_to :sorbet
    end
    add_index :habanero_ingredients, :sorbet_id
  end
end
