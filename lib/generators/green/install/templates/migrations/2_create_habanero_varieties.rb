class CreateHabaneroVarieties < ActiveRecord::Migration
  def change
    create_table "habanero_varieties", :force => true do |t|
      t.integer "brand_id"
      t.string  "name"
      t.integer "parent_id"
      t.integer "lft"
      t.integer "rgt"
      t.string  "slug"
      t.boolean "suppress_automatic_naming"
      t.text "documentation"
    end

    add_index "habanero_varieties", "slug"
  end
end
