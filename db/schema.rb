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

ActiveRecord::Schema.define(version: 20161028102537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "assets", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.uuid     "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["owner_id"], name: "index_assets_on_owner_id", using: :btree
    t.index ["owner_type"], name: "index_assets_on_owner_type", using: :btree
  end

  create_table "client_sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "external_session_key"
    t.string   "vessel_reg_no"
    t.integer  "access_code"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["external_session_key"], name: "index_client_sessions_on_external_session_key", using: :btree
    t.index ["vessel_reg_no"], name: "index_client_sessions_on_vessel_reg_no", using: :btree
  end

  create_table "custom_auto_increments", force: :cascade do |t|
    t.string   "counter_model_name"
    t.integer  "counter",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["counter_model_name"], name: "index_custom_auto_increments_on_counter_model_name", using: :btree
  end

  create_table "customers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "vessel_id"
    t.string   "type"
    t.string   "email"
    t.string   "name"
    t.string   "nationality"
    t.string   "phone_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["email"], name: "index_customers_on_email", using: :btree
    t.index ["type"], name: "index_customers_on_type", using: :btree
    t.index ["vessel_id"], name: "index_customers_on_vessel_id", using: :btree
  end

  create_table "declarations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.string   "state"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.uuid     "notification_id"
    t.datetime "completed_at"
    t.json     "changeset"
    t.uuid     "completed_by_id"
    t.string   "completed_form_file_name"
    t.string   "completed_form_content_type"
    t.integer  "completed_form_file_size"
    t.datetime "completed_form_updated_at"
    t.index ["completed_by_id"], name: "index_declarations_on_completed_by_id", using: :btree
    t.index ["notification_id"], name: "index_declarations_on_notification_id", using: :btree
    t.index ["state"], name: "index_declarations_on_state", using: :btree
    t.index ["submission_id"], name: "index_declarations_on_submission_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "finance_payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "part"
    t.string   "task"
    t.string   "vessel_name"
    t.string   "service_level"
    t.string   "payment_type"
    t.decimal  "payment_amount"
    t.string   "receipt_no"
    t.string   "applicant_name"
    t.string   "applicant_email"
    t.string   "documents_received"
    t.uuid     "actioned_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.date     "payment_date"
    t.string   "vessel_reg_no"
    t.index ["actioned_by_id"], name: "index_finance_payments_on_actioned_by_id", using: :btree
  end

  create_table "notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "noteable_id"
    t.string   "noteable_type"
    t.uuid     "actioned_by_id"
    t.string   "type"
    t.string   "subject"
    t.string   "format"
    t.datetime "noted_at"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["actioned_by_id"], name: "index_notes_on_actioned_by_id", using: :btree
    t.index ["noteable_id"], name: "index_notes_on_noteable_id", using: :btree
    t.index ["noteable_type"], name: "index_notes_on_noteable_type", using: :btree
    t.index ["type"], name: "index_notes_on_type", using: :btree
  end

  create_table "notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "type"
    t.string   "subject"
    t.text     "body"
    t.uuid     "actioned_by_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.uuid     "notifiable_id"
    t.string   "notifiable_type"
    t.string   "recipient_name"
    t.string   "recipient_email"
    t.string   "attachments"
    t.index ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree
    t.index ["notifiable_type"], name: "index_notifications_on_notifiable_type", using: :btree
    t.index ["type"], name: "index_notifications_on_type", using: :btree
  end

  create_table "payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remittance_type"
    t.uuid     "remittance_id"
    t.integer  "amount"
    t.index ["remittance_id"], name: "index_payments_on_remittance_id", using: :btree
    t.index ["remittance_type"], name: "index_payments_on_remittance_type", using: :btree
    t.index ["submission_id"], name: "index_payments_on_submission_id", using: :btree
  end

  create_table "registrations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "vessel_id"
    t.uuid     "submission_id"
    t.datetime "registered_at"
    t.datetime "registered_until"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.uuid     "actioned_by_id"
    t.index ["actioned_by_id"], name: "index_registrations_on_actioned_by_id", using: :btree
  end

  create_table "roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "target_date"
    t.boolean  "is_urgent"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.uuid     "delivery_address_id"
    t.json     "changeset"
    t.string   "part"
    t.string   "state"
    t.uuid     "claimant_id"
    t.datetime "referred_until"
    t.string   "ref_no"
    t.datetime "received_at"
    t.json     "print_jobs"
    t.string   "task"
    t.string   "source"
    t.boolean  "officer_intervention_required"
    t.uuid     "registered_vessel_id"
    t.json     "registry_info"
    t.index ["claimant_id"], name: "index_submissions_on_claimant_id", using: :btree
    t.index ["part"], name: "index_submissions_on_part", using: :btree
    t.index ["ref_no"], name: "index_submissions_on_ref_no", using: :btree
    t.index ["state"], name: "index_submissions_on_state", using: :btree
  end

  create_table "user_roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "vessels", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "hin"
    t.string   "make_and_model"
    t.integer  "number_of_hulls",  null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "mmsi_number"
    t.string   "radio_call_sign"
    t.string   "vessel_type"
    t.decimal  "length_in_meters"
    t.string   "reg_no"
    t.index ["hin"], name: "index_vessels_on_hin", using: :btree
    t.index ["mmsi_number"], name: "index_vessels_on_mmsi_number", using: :btree
    t.index ["name"], name: "index_vessels_on_name", using: :btree
    t.index ["radio_call_sign"], name: "index_vessels_on_radio_call_sign", using: :btree
    t.index ["reg_no"], name: "index_vessels_on_reg_no", using: :btree
  end

  create_table "world_pay_payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "wp_token"
    t.string   "wp_order_code"
    t.string   "wp_country"
    t.string   "customer_ip"
    t.json     "wp_payment_response"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
