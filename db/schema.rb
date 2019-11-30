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

ActiveRecord::Schema.define(version: 2019_10_01_181548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_settings", force: :cascade do |t|
    t.boolean "allow_registration", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "show_lowest_price", default: false
    t.boolean "show_saving_percentage", default: false
    t.decimal "visit_timer", precision: 7, scale: 4, default: "6.0"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super_admin", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "icon"
    t.string "name"
    t.string "name_en"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_in_file"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.text "description"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.string "sheet_name"
    t.string "sheet_url_name"
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "order_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed"
    t.integer "confirmed_by"
    t.datetime "checkout_at"
    t.datetime "confirmed_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_informations", force: :cascade do |t|
    t.bigint "market_id"
    t.bigint "product_id"
    t.decimal "price", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "market_url"
    t.index ["market_id"], name: "index_product_informations_on_market_id"
    t.index ["product_id"], name: "index_product_informations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.text "description"
    t.string "main_image"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "lowest_price", precision: 6, scale: 2
    t.decimal "highest_price", precision: 6, scale: 2
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visits_count", default: 1
    t.datetime "last_visit"
    t.index ["mobile"], name: "index_users_on_mobile", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_informations", "markets"
  add_foreign_key "product_informations", "products"
  add_foreign_key "products", "categories"
end
