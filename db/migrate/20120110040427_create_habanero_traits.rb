class CreateHabaneroTraits < ActiveRecord::Migration
  def change
    create_table :habanero_traits do |t|
      t.belongs_to :variety
    end
    add_index :habanero_traits, :variety_id
  end
end
