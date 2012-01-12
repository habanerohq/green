class AddNameToHabaneroSorbets < ActiveRecord::Migration
  def change
    add_column :habanero_sorbets, :name, :string
  end
end
