class AddNameToHabaneroNamespaces < ActiveRecord::Migration
  def change
    add_column :habanero_namespaces, :name, :string
  end
end
