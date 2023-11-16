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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20231114023747) do

  create_table "products", primary_key: "product_id", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.string  "description"
    t.string  "price"
    t.string  "location"
    t.boolean "is_sold?",    default: false
    t.string  "user_email"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "purchase_timestamp"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "purchases", ["product_id"], name: "index_purchases_on_product_id"
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.string "email"
    t.string "name"
    t.string "session_token"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token"

end
