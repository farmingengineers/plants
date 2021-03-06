# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130208182230) do

  create_table "catalog_items", :force => true do |t|
    t.integer  "catalog_page_id"
    t.string   "name"
    t.boolean  "organic"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "catalog_items", ["catalog_page_id"], :name => "index_catalog_items_on_catalog_page_id"

  create_table "catalog_pages", :force => true do |t|
    t.integer  "catalog_id"
    t.string   "url"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "catalog_pages", ["catalog_id"], :name => "index_catalog_pages_on_catalog_id"

  create_table "catalog_prices", :force => true do |t|
    t.integer  "catalog_item_id"
    t.string   "quantity"
    t.integer  "cents"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "catalog_prices", ["catalog_item_id"], :name => "index_catalog_prices_on_catalog_item_id"

  create_table "catalogs", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
