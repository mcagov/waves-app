class RebuildTablesWithUuidPrimaryKey < ActiveRecord::Migration[5.0]
  def change
    create_table "activities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "trackable_id"
      t.string   "trackable_type"
      t.uuid     "actioned_by"
      t.text     "description"
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
      t.index ["actioned_by"], name: "index_activities_on_actioned_by", using: :btree
      t.index ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
      t.index ["trackable_type"], name: "index_activities_on_trackable_type", using: :btree
    end

    create_table "countries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   "name"
      t.string   "code"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["code"], name: "index_countries_on_code", using: :btree
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
      t.uuid     "submission_id"
      t.string   "type"
      t.string   "subject"
      t.text     "body"
      t.boolean  "delivered",      default: false
      t.uuid     "actioned_by_id"
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
      t.index ["type"], name: "index_notifications_on_type", using: :btree
    end
  end
end
