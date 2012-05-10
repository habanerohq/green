class AddSuppressAutomaticNamingToVarieties < ActiveRecord::Migration
  def change
    add_column :habanero_varieties, :suppress_automatic_naming, :boolean
  end
end
