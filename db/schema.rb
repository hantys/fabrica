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

ActiveRecord::Schema.define(version: 2018_05_07_045601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compositionals", force: :cascade do |t|
    t.integer "raw_material_id"
    t.integer "composition_id"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_material_id", "composition_id"], name: "index_compositionals_on_raw_material_id_and_composition_id"
  end

  create_table "compositions", force: :cascade do |t|
    t.string "name"
    t.float "weight", default: 0.0
    t.float "amount", default: 0.0
    t.integer "kind"
    t.integer "parent_composition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_materials", force: :cascade do |t|
    t.string "name"
    t.string "slug_name"
    t.float "amount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_final_products", force: :cascade do |t|
    t.bigint "composition_id"
    t.float "weight"
    t.float "estimated_weight"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["composition_id"], name: "index_stock_final_products_on_composition_id"
  end

  create_table "stock_raw_materials", force: :cascade do |t|
    t.bigint "raw_material_id"
    t.float "weight"
    t.float "weight_out"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_material_id"], name: "index_stock_raw_materials_on_raw_material_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.datetime "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "stock_final_products", "compositions"
  add_foreign_key "stock_raw_materials", "raw_materials"
end
