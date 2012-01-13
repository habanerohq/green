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

ActiveRecord::Schema.define(:version => 20120113014443) do

  create_table "habanero_ingredients", :force => true do |t|
    t.integer "sorbet_id"
    t.string  "name"
  end

  add_index "habanero_ingredients", ["sorbet_id"], :name => "index_habanero_ingredients_on_sorbet_id"

  create_table "habanero_namespaces", :force => true do |t|
    t.string "name"
  end

  create_table "habanero_sorbets", :force => true do |t|
    t.integer "namespace_id"
    t.string  "name"
    t.integer "super_id"
  end

end
