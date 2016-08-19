class RuthlessCleanup < ActiveRecord::Migration[5.0]
  def change

    drop_table "addresses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
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

    create_table "user_vessel_submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "user_id"
      t.json     "changes",       default: {}, null: false
      t.datetime "created_at",                 null: false
      t.datetime "updated_at",                 null: false
      t.uuid     "submission_id"
    end

    create_table "vessel_submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "vessel_id"
      t.uuid     "submission_id"
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
    end
  end
end
