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

ActiveRecord::Schema.define(version: 20160615140821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
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

  create_table "owner_addresses", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owner_vessels", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "vessel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "first_name",              null: false
    t.string   "last_name",               null: false
    t.string   "nationality",   limit: 2, null: false
    t.string   "email",                   null: false
    t.string   "phone_number"
    t.string   "mobile_number",           null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title"
    t.integer  "address_id"
  end

  create_table "register_vessels", force: :cascade do |t|
    t.integer  "register_id"
    t.integer  "vessel_id"
    t.string   "status",          null: false
    t.datetime "expiry_date",     null: false
    t.integer  "register_number", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "registers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "ip_country"
    t.string   "card_country"
    t.string   "browser",      null: false
    t.string   "payment_id"
    t.string   "receipt_id"
    t.string   "status",       null: false
    t.datetime "due_date"
    t.boolean  "is_urgent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "vessel_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_vessel_registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.json     "changes",         default: {}, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "registration_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "ldap_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "vessel_registrations", force: :cascade do |t|
    t.integer  "vessel_id"
    t.integer  "registration_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "vessel_types", force: :cascade do |t|
    t.string   "designation", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vessels", force: :cascade do |t|
    t.string   "name",                  null: false
    t.string   "hin"
    t.string   "make_and_model"
    t.integer  "length_in_centimeters", null: false
    t.integer  "number_of_hulls",       null: false
    t.integer  "vessel_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "vessel_type_other"
    t.integer  "mmsi_number",           null: false
    t.string   "radio_call_sign",       null: false
  end

  add_index "vessels", ["vessel_type_id"], name: "index_vessels_on_vessel_type_id", using: :btree

end
