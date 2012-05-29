class CreateHabaneroBrands < ActiveRecord::Migration
  def change
    create_table "habanero_brands", :force => true do |t|
      t.string "name"
      t.string "slug"
      t.text "documentation"
    end

    add_index "habanero_brands", "slug"
  end
end
