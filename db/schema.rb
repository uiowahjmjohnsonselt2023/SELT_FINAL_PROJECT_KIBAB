# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_01_005930) do
  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_bookmarks_on_product_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "image"
    t.string "category"
    t.string "quality"
    t.string "description"
    t.string "price"
    t.string "city"
    t.string "state"
    t.string "street_address"
    t.string "zip"
    t.string "lat"
    t.string "long"
    t.boolean "is_sold", default: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "purchase_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "seller_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "review"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_seller_reviews_on_user_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_shopping_carts_on_product_id"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.string "email"
    t.string "name"
    t.string "pfp"
    t.string "session_token"
    t.index ["session_token"], name: "index_users_on_session_token"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id"
    t.float "wallet", default: 100.0
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "bookmarks", "products"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "products", "users"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
  add_foreign_key "seller_reviews", "users"
  add_foreign_key "shopping_carts", "products"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "wallets", "users"
end
