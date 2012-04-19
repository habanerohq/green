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

  create_table "habanero_brands", :force => true do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "habanero_traits", :force => true do |t|
    t.integer "variety_id"
    t.string  "name"
    t.string  "type"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
  end

  add_index "habanero_traits", ["variety_id"], :name => "index_habanero_traits_on_variety_id"

  create_table "habanero_varieties", :force => true do |t|
    t.integer "brand_id"
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
  end

end
