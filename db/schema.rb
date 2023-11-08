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

ActiveRecord::Schema.define(version: 20231108032307) do

  create_table "products", primary_key: "product_id", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.string  "description"
    t.string  "price"
    t.string  "location"
    t.boolean "is_sold?"
    t.integer "user_id"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "email"
    t.string "password_hash"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
  end

end
