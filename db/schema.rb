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

ActiveRecord::Schema.define(version: 2018_06_10_023200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_products", force: :cascade do |t|
    t.bigint "budget_id"
    t.float "unit_value", default: 0.0
    t.float "qnt", default: 0.0
    t.float "total_value", default: 0.0
    t.float "total_value_with_discount", default: 0.0
    t.float "discount", default: 0.0
    t.boolean "discount_type", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["budget_id"], name: "index_budget_products_on_budget_id"
    t.index ["product_id"], name: "index_budget_products_on_product_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id"
    t.bigint "employee_id"
    t.float "value", default: 0.0
    t.float "discount_items", default: 0.0
    t.float "value_with_discount", default: 0.0
    t.date "deadline"
    t.integer "delivery_options"
    t.integer "payment_term"
    t.integer "type_of_payment"
    t.float "discount", default: 0.0
    t.boolean "discount_type", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_budgets_on_client_id"
    t.index ["employee_id"], name: "index_budgets_on_employee_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.boolean "capital"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "company_name"
    t.string "fantasy_name"
    t.string "cpf"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "cep"
    t.string "cnpj"
    t.string "ie"
    t.bigint "state_id"
    t.bigint "city_id"
    t.string "phone1"
    t.string "phone2"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_clients_on_city_id"
    t.index ["employee_id"], name: "index_clients_on_employee_id"
    t.index ["state_id"], name: "index_clients_on_state_id"
  end

  create_table "compositionals", force: :cascade do |t|
    t.integer "raw_material_id"
    t.integer "composition_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "composition_id"], name: "index_compositionals_on_parent_id_and_composition_id"
    t.index ["raw_material_id", "composition_id"], name: "index_compositionals_on_raw_material_id_and_composition_id"
  end

  create_table "compositions", force: :cascade do |t|
    t.string "name"
    t.float "weight", default: 0.0
    t.float "amount", default: 0.0
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "email"
    t.string "office"
    t.string "bank"
    t.string "ag"
    t.string "cc"
    t.string "variation"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "cep"
    t.bigint "state_id"
    t.bigint "city_id"
    t.string "phone1"
    t.string "phone2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_employees_on_city_id"
    t.index ["state_id"], name: "index_employees_on_state_id"
  end

  create_table "hit_item_stocks", force: :cascade do |t|
    t.bigint "hit_item_id"
    t.bigint "stock_raw_material_id"
    t.float "weight", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hit_item_id"], name: "index_hit_item_stocks_on_hit_item_id"
    t.index ["stock_raw_material_id"], name: "index_hit_item_stocks_on_stock_raw_material_id"
  end

  create_table "hit_items", force: :cascade do |t|
    t.bigint "raw_material_id"
    t.bigint "hit_id"
    t.float "weight", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hit_id"], name: "index_hit_items_on_hit_id"
    t.index ["raw_material_id"], name: "index_hit_items_on_raw_material_id"
  end

  create_table "hits", force: :cascade do |t|
    t.string "name"
    t.float "residue", default: 0.0
    t.boolean "used", default: false
    t.bigint "composition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["composition_id"], name: "index_hits_on_composition_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "cod"
    t.string "name"
    t.float "price", default: 0.0
    t.float "weight", default: 0.0
    t.float "qnt", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "company_name"
    t.string "fantasy_name"
    t.string "cpf"
    t.string "cnpj"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "cep"
    t.string "ie"
    t.string "bank"
    t.string "ag"
    t.string "cc"
    t.string "variation"
    t.bigint "state_id"
    t.bigint "city_id"
    t.string "phone1"
    t.string "phone2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_providers_on_city_id"
    t.index ["state_id"], name: "index_providers_on_state_id"
  end

  create_table "raw_materials", force: :cascade do |t|
    t.string "name"
    t.string "slug_name"
    t.float "amount", default: 0.0
    t.float "weight", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_raw_materials_on_name", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acronym"], name: "index_states_on_acronym"
    t.index ["name"], name: "index_states_on_name"
  end

  create_table "stock_final_products", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.float "weight", default: 0.0
    t.float "amount", default: 0.0
    t.float "estimated_weight", default: 0.0
    t.float "cost", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hit_id"
    t.bigint "product_id"
    t.index ["hit_id"], name: "index_stock_final_products_on_hit_id"
    t.index ["product_id"], name: "index_stock_final_products_on_product_id"
  end

  create_table "stock_raw_materials", force: :cascade do |t|
    t.bigint "raw_material_id"
    t.float "weight", default: 0.0
    t.float "weight_out", default: 0.0
    t.float "price", default: 0.0
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
    t.bigint "employee_id"
    t.integer "roles_mask"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "budget_products", "budgets"
  add_foreign_key "budget_products", "products"
  add_foreign_key "budgets", "clients"
  add_foreign_key "budgets", "employees"
  add_foreign_key "cities", "states"
  add_foreign_key "clients", "cities"
  add_foreign_key "clients", "employees"
  add_foreign_key "clients", "states"
  add_foreign_key "employees", "cities"
  add_foreign_key "employees", "states"
  add_foreign_key "hit_items", "hits"
  add_foreign_key "hit_items", "raw_materials"
  add_foreign_key "hits", "compositions"
  add_foreign_key "providers", "cities"
  add_foreign_key "providers", "states"
  add_foreign_key "stock_final_products", "hits"
  add_foreign_key "stock_final_products", "products"
  add_foreign_key "stock_raw_materials", "raw_materials"
  add_foreign_key "users", "employees"
end
