# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120306055304) do

  create_table "cellar_items", :force => true do |t|
    t.integer  "record_id"
    t.string   "record_type"
    t.text     "item"
    t.string   "pantry_type"
    t.datetime "stacked_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cellar_migrations", :id => false, :force => true do |t|
    t.string "version", :null => false
  end

  add_index "cellar_migrations", ["version"], :name => "index_cellar_migrations_on_version", :unique => true

  create_table "habanero_categories", :force => true do |t|
    t.string  "abbreviation"
    t.text    "strategy"
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
  end

  add_index "habanero_categories", ["slug"], :name => "index_habanero_categories_on_slug", :unique => true

  create_table "habanero_conditions", :force => true do |t|
    t.string  "predicate"
    t.string  "value"
    t.integer "ingredient_id"
    t.integer "query_id"
    t.integer "query_position"
  end

  create_table "habanero_ingredients", :force => true do |t|
    t.integer "sorbet_id"
    t.string  "name"
    t.string  "type"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
    t.string  "sort_direction"
    t.string  "relation"
    t.string  "format"
    t.text    "documentation"
    t.boolean "derived"
    t.boolean "nullable"
    t.boolean "sortable"
    t.boolean "ordered"
    t.integer "limit"
    t.integer "precision"
    t.integer "scale"
    t.integer "default"
    t.integer "scope_id"
    t.integer "target_id"
    t.integer "category_id"
  end

  add_index "habanero_ingredients", ["slug"], :name => "index_habanero_ingredients_on_slug"
  add_index "habanero_ingredients", ["sorbet_id"], :name => "index_habanero_ingredients_on_sorbet_id"

  create_table "habanero_layout_rows", :force => true do |t|
    t.boolean "fluid"
    t.string  "name"
    t.integer "layout_id"
    t.integer "layout_position"
  end

  create_table "habanero_layouts", :force => true do |t|
    t.string  "template_name"
    t.boolean "fluid"
    t.string  "name"
    t.string  "slug"
  end

  add_index "habanero_layouts", ["slug"], :name => "index_habanero_layouts_on_slug", :unique => true

  create_table "habanero_mask_ingredients", :force => true do |t|
    t.integer "mask_id"
    t.integer "mask_position"
    t.integer "ingredient_id"
  end

  create_table "habanero_masks", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "sorbet_id"
    t.string  "slug"
  end

  add_index "habanero_masks", ["slug"], :name => "index_habanero_masks_on_slug"

  create_table "habanero_namespaces", :force => true do |t|
    t.string "name"
    t.string "slug"
    t.text   "documentation"
  end

  add_index "habanero_namespaces", ["slug"], :name => "index_habanero_namespaces_on_slug", :unique => true

  create_table "habanero_pages", :force => true do |t|
    t.string  "name"
    t.integer "layout_id"
    t.integer "template_id"
    t.integer "section_id"
    t.integer "section_position"
    t.integer "target_id"
    t.integer "next_page_id"
    t.string  "slug"
    t.string  "route"
  end

  add_index "habanero_pages", ["slug"], :name => "index_habanero_pages_on_slug"

  create_table "habanero_queries", :force => true do |t|
    t.string  "name"
    t.integer "sorbet_id"
  end

  create_table "habanero_regions", :force => true do |t|
    t.integer "span"
    t.integer "offset"
    t.string  "name"
    t.integer "layout_id"
    t.integer "row_id"
    t.integer "row_position"
    t.string  "slug"
  end

  add_index "habanero_regions", ["slug"], :name => "index_habanero_regions_on_slug"

  create_table "habanero_scoop_placements", :force => true do |t|
    t.string  "template"
    t.integer "scoop_id"
    t.integer "page_id"
    t.integer "region_id"
    t.integer "region_position"
  end

  create_table "habanero_scoops", :force => true do |t|
    t.string  "type"
    t.string  "title"
    t.string  "body_format"
    t.string  "template"
    t.text    "body"
    t.integer "columns"
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "page_id"
    t.integer "mask_id"
    t.string  "slug"
  end

  add_index "habanero_scoops", ["slug"], :name => "index_habanero_scoops_on_slug", :unique => true

  create_table "habanero_sections", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "site_id"
    t.integer "site_position"
    t.integer "template_id"
    t.integer "target_id"
    t.string  "slug"
    t.string  "route"
  end

  add_index "habanero_sections", ["slug"], :name => "index_habanero_sections_on_slug"

  create_table "habanero_sites", :force => true do |t|
    t.string  "host"
    t.string  "name"
    t.integer "root_page_id"
    t.string  "slug"
  end

  add_index "habanero_sites", ["slug"], :name => "index_habanero_sites_on_slug", :unique => true

  create_table "habanero_sorbets", :force => true do |t|
    t.integer "namespace_id"
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
    t.text    "documentation"
  end

  add_index "habanero_sorbets", ["slug"], :name => "index_habanero_sorbets_on_slug"

end
