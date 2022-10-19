# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_30_142008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_contact_roles", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "account_id"
    t.string "role", null: false
    t.boolean "primary", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_contact_roles_on_account_id"
    t.index ["contact_id", "account_id"], name: "index_account_contact_roles_on_contact_id_and_account_id"
    t.index ["contact_id"], name: "index_account_contact_roles_on_contact_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "territory_id"
    t.string "name", null: false
    t.bigint "parent_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_account_id"], name: "index_accounts_on_parent_account_id"
    t.index ["territory_id"], name: "index_accounts_on_territory_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "preferred_name", default: "", null: false
    t.string "primary_phone"
    t.string "secondary_phone"
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_contacts_on_email", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "company_signed_by_id"
    t.date "company_signed_date"
    t.bigint "customer_signed_by_id"
    t.date "customer_signed_date"
    t.date "activated_date"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_contracts_on_account_id"
    t.index ["company_signed_by_id"], name: "index_contracts_on_company_signed_by_id"
    t.index ["customer_signed_by_id"], name: "index_contracts_on_customer_signed_by_id"
  end

  create_table "jti_claims", force: :cascade do |t|
    t.bigint "user_id"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_jti_claims_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content", null: false
    t.string "notable_type", null: false
    t.bigint "notable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "account_id"
    t.bigint "owner_id"
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.date "close_date", null: false
    t.string "forecast_category", null: false
    t.string "stage", null: false
    t.string "lead_source", null: false
    t.boolean "existing_business", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "contract_id"
    t.index ["account_id"], name: "index_opportunities_on_account_id"
    t.index ["contract_id"], name: "index_opportunities_on_contract_id"
    t.index ["owner_id"], name: "index_opportunities_on_owner_id"
  end

  create_table "opportunity_products", force: :cascade do |t|
    t.bigint "opportunity_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["opportunity_id", "product_id"], name: "index_opportunity_products_on_opportunity_id_and_product_id"
    t.index ["opportunity_id"], name: "index_opportunity_products_on_opportunity_id"
    t.index ["product_id"], name: "index_opportunity_products_on_product_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.bigint "quote_line_item_id"
    t.date "start_date"
    t.date "end_date", null: false
    t.integer "quantity"
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.index ["order_id", "product_id"], name: "index_order_products_on_order_id_and_product_id"
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
    t.index ["quote_line_item_id"], name: "index_order_products_on_quote_line_item_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "account_id"
    t.date "activated_date"
    t.bigint "company_authorized_by_id"
    t.date "company_authorized_date"
    t.bigint "customer_authorized_by_id"
    t.date "customer_authorized_date"
    t.bigint "opportunity_id"
    t.bigint "quote_id"
    t.bigint "contract_id"
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "order_type", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["company_authorized_by_id"], name: "index_orders_on_company_authorized_by_id"
    t.index ["contract_id"], name: "index_orders_on_contract_id"
    t.index ["customer_authorized_by_id"], name: "index_orders_on_customer_authorized_by_id"
    t.index ["opportunity_id"], name: "index_orders_on_opportunity_id"
    t.index ["quote_id"], name: "index_orders_on_quote_id"
  end

  create_table "price_book_entries", force: :cascade do |t|
    t.decimal "list_price", precision: 8, scale: 2, null: false
    t.boolean "is_active", default: true, null: false
    t.bigint "price_book_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["price_book_id", "product_id"], name: "index_price_book_entries_on_price_book_id_and_product_id"
    t.index ["price_book_id"], name: "index_price_book_entries_on_price_book_id"
    t.index ["product_id"], name: "index_price_book_entries_on_product_id"
  end

  create_table "price_books", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: "", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: true, null: false
    t.string "code", null: false
    t.text "description", default: "", null: false
    t.string "quantity_unit_of_measure", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quote_line_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "quote_id"
    t.bigint "sales_price_id"
    t.date "effective_date", null: false
    t.decimal "discount", precision: 8, scale: 2, null: false
    t.integer "quantity"
    t.index ["product_id", "quote_id"], name: "index_quote_line_items_on_product_id_and_quote_id"
    t.index ["product_id"], name: "index_quote_line_items_on_product_id"
    t.index ["quote_id"], name: "index_quote_line_items_on_quote_id"
    t.index ["sales_price_id"], name: "index_quote_line_items_on_sales_price_id"
  end

  create_table "quote_templates", force: :cascade do |t|
    t.string "title"
    t.text "markdown_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "contact_id"
    t.bigint "opportunity_id"
    t.string "status", null: false
    t.date "expiration_date", null: false
    t.decimal "tax", precision: 8, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_quotes_on_account_id"
    t.index ["contact_id"], name: "index_quotes_on_contact_id"
    t.index ["opportunity_id"], name: "index_quotes_on_opportunity_id"
  end

  create_table "territories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "advisor_id"
    t.bigint "sales_id"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["advisor_id"], name: "index_territories_on_advisor_id"
    t.index ["parent_id"], name: "index_territories_on_parent_id"
    t.index ["sales_id"], name: "index_territories_on_sales_id"
  end

  create_table "territory_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "territory_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "territory_desc_idx"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "account_contact_roles", "accounts"
  add_foreign_key "account_contact_roles", "contacts"
  add_foreign_key "accounts", "territories"
  add_foreign_key "contracts", "accounts"
  add_foreign_key "contracts", "contacts", column: "customer_signed_by_id"
  add_foreign_key "contracts", "users", column: "company_signed_by_id"
  add_foreign_key "jti_claims", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "opportunities", "accounts"
  add_foreign_key "opportunities", "contracts"
  add_foreign_key "opportunities", "users", column: "owner_id"
  add_foreign_key "opportunity_products", "opportunities"
  add_foreign_key "opportunity_products", "products"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "order_products", "quote_line_items"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "contacts", column: "customer_authorized_by_id"
  add_foreign_key "orders", "contracts"
  add_foreign_key "orders", "opportunities"
  add_foreign_key "orders", "quotes"
  add_foreign_key "orders", "users", column: "company_authorized_by_id"
  add_foreign_key "price_book_entries", "price_books"
  add_foreign_key "price_book_entries", "products"
  add_foreign_key "quote_line_items", "price_book_entries", column: "sales_price_id"
  add_foreign_key "quote_line_items", "products"
  add_foreign_key "quote_line_items", "quotes"
  add_foreign_key "quotes", "accounts"
  add_foreign_key "quotes", "contacts"
  add_foreign_key "quotes", "opportunities"
  add_foreign_key "territories", "users", column: "advisor_id"
  add_foreign_key "territories", "users", column: "sales_id"
end
