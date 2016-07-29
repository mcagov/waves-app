class FlattenMigrations < ActiveRecord::Migration[5.0]
  def change
    enable_extension "plpgsql"
    enable_extension 'uuid-ossp'

    create_table "addresses", id: :uuid, force: :cascade do |t|
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

    create_table "owner_vessels", id: :uuid, force: :cascade do |t|
      t.integer  "owner_id"
      t.integer  "vessel_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "owners", id: :uuid, force: :cascade do |t|
      t.string   "first_name",             null: false
      t.string   "last_name",              null: false
      t.string   "nationality",  limit: 2, null: false
      t.string   "email",                  null: false
      t.string   "phone_number",           null: false
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
      t.string   "title"
      t.integer  "address_id"
    end

    create_table "register_vessels", id: :uuid, force: :cascade do |t|
      t.integer  "register_id"
      t.integer  "vessel_id"
      t.string   "status",          null: false
      t.datetime "expiry_date",     null: false
      t.integer  "register_number", null: false
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "registers", id: :uuid, force: :cascade do |t|
      t.string   "name",       null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "registrations", id: :uuid, force: :cascade do |t|
      t.string   "ip_country"
      t.string   "card_country"
      t.string   "payment_id"
      t.string   "receipt_id"
      t.string   "status",              null: false
      t.datetime "due_date"
      t.boolean  "is_urgent"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.integer  "vessel_id"
      t.integer  "delivery_address_id"
    end

    create_table "roles", id: :uuid, force: :cascade do |t|
      t.string   "name",       null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "user_roles", id: :uuid, force: :cascade do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "user_vessel_registrations", id: :uuid, force: :cascade do |t|
      t.integer  "user_id"
      t.json     "changes",         default: {}, null: false
      t.datetime "created_at",                   null: false
      t.datetime "updated_at",                   null: false
      t.integer  "registration_id"
    end

    create_table "users", id: :uuid, force: :cascade do |t|
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

    create_table "vessel_registrations", id: :uuid, force: :cascade do |t|
      t.integer  "vessel_id"
      t.integer  "registration_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "vessel_types", id: :uuid, force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "name"
      t.string   "key"
    end

    create_table "vessels", id: :uuid, force: :cascade do |t|
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
      t.index ["vessel_type_id"], name: "index_vessels_on_vessel_type_id", using: :btree
    end
  end
end
