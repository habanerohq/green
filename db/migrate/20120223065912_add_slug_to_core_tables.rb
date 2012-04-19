class AddSlugToCoreTables < ActiveRecord::Migration
  def change
    add_column :habanero_brands, :slug, :string
    add_column :habanero_varieties, :slug, :string
    add_column :habanero_ingredients, :slug, :string
  end
end
