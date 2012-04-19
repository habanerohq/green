class AddNameToHabaneroTraits < ActiveRecord::Migration
  def change
    add_column :habanero_traits, :name, :string
  end
end
