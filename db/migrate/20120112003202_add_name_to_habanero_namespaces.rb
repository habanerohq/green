class AddNameToHabaneroBrands < ActiveRecord::Migration
  def change
    add_column :habanero_brands, :name, :string
  end
end
