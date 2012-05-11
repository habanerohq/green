class CreateHabaneroTraits < ActiveRecord::Migration
  def change
    create_table "habanero_traits", :force => true do |t|
      t.integer "variety_id"
      t.string  "name"
      t.string  "type"
      t.integer "parent_id"
      t.integer "lft"
      t.integer "rgt"
      t.string  "slug"
    end

    add_index "habanero_traits", "slug"
  end
end
