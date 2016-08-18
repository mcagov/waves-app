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

ActiveRecord::Schema.define(version: 20160818074228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "addresses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "address_1",            null: false
    t.string   "address_2"
    t.string   "address_3"
    t.string   "town",                 null: false
    t.string   "county"
    t.string   "postcode",             null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "country",    limit: 2
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", using: :btree
  end

  create_table "owner_vessels", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "owner_id"
    t.integer  "vessel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "nationality",  limit: 2, null: false
    t.string   "email",                  null: false
    t.string   "phone_number",           null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "title"
    t.uuid     "address_id"
  end

  create_table "payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "wp_token"
    t.string   "wp_order_code"
    t.string   "wp_amount"
    t.string   "wp_country"
    t.string   "customer_ip"
    t.json     "wp_payment_response"
    t.index ["submission_id"], name: "index_payments_on_submission_id", using: :btree
  end

  create_table "register_vessels", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "register_id"
    t.uuid     "vessel_id"
    t.string   "status",          null: false
    t.datetime "expiry_date",     null: false
    t.uuid     "register_number", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "registers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "ip_country"
    t.string   "card_country"
    t.string   "payment_id"
    t.string   "receipt_id"
    t.datetime "due_date"
    t.boolean  "is_urgent"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.uuid     "vessel_id"
    t.uuid     "delivery_address_id"
    t.json     "changeset"
    t.string   "register"
    t.string   "task"
    t.index ["register"], name: "index_submissions_on_register", using: :btree
    t.index ["task"], name: "index_submissions_on_task", using: :btree
  end

  create_table "roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_vessel_submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.json     "changes",         default: {}, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.uuid     "submission_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "ldap_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "vessel_submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "vessel_id"
    t.uuid     "submission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "vessel_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "key"
  end

  create_table "vessels", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                  null: false
    t.string   "hin"
    t.string   "make_and_model"
    t.integer  "length_in_centimeters", null: false
    t.integer  "number_of_hulls",       null: false
    t.uuid     "vessel_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "vessel_type_other"
    t.integer  "mmsi_number",           null: false
    t.string   "radio_call_sign",       null: false
    t.index ["vessel_type_id"], name: "index_vessels_on_vessel_type_id", using: :btree
  end

end
