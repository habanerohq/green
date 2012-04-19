class AddTypeToHabaneroTraits < ActiveRecord::Migration
  def change
    add_column :habanero_traits, :type, :string
  end
end
