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

ActiveRecord::Schema.define(:version => 20120530053803) do

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
    t.text   "documentation"
  end

  add_index "habanero_brands", ["slug"], :name => "index_habanero_brands_on_slug", :unique => true

  create_table "habanero_traits", :force => true do |t|
    t.integer "variety_id"
    t.string  "name"
    t.string  "type"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
    t.string  "sort_direction"
    t.string  "relation"
    t.string  "associated_name"
    t.string  "format"
    t.text    "documentation"
    t.boolean "derived"
    t.boolean "nullable"
    t.boolean "sortable"
    t.boolean "ordered"
    t.boolean "no_html"
    t.boolean "primary"
    t.boolean "polymorphic"
    t.integer "limit"
    t.integer "precision"
    t.integer "scale"
    t.integer "default"
    t.integer "associated_type_id"
    t.integer "category_id"
    t.integer "scope_id"
    t.integer "target_id"
  end

  add_index "habanero_traits", ["slug"], :name => "index_habanero_traits_on_slug"
  add_index "habanero_traits", ["variety_id"], :name => "index_habanero_traits_on_variety_id"

  create_table "habanero_varieties", :force => true do |t|
    t.integer "brand_id"
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string  "slug"
    t.boolean "suppress_automatic_naming"
    t.text    "documentation"
    t.integer "category_id"
  end

  add_index "habanero_varieties", ["slug"], :name => "index_habanero_varieties_on_slug"

  create_table "jalapeno_users", :force => true do |t|
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "jalapeno_users", ["authentication_token"], :name => "index_jalapeno_users_on_authentication_token", :unique => true
  add_index "jalapeno_users", ["confirmation_token"], :name => "index_jalapeno_users_on_confirmation_token", :unique => true
  add_index "jalapeno_users", ["email"], :name => "index_jalapeno_users_on_email", :unique => true
  add_index "jalapeno_users", ["reset_password_token"], :name => "index_jalapeno_users_on_reset_password_token", :unique => true
  add_index "jalapeno_users", ["unlock_token"], :name => "index_jalapeno_users_on_unlock_token", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
