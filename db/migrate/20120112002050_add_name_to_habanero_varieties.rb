class AddNameToHabaneroVarieties < ActiveRecord::Migration
  def change
    add_column :habanero_varieties, :name, :string
  end
end
