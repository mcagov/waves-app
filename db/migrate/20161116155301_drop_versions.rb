class DropVersions < ActiveRecord::Migration[5.0]
  def change
    drop_table "versions", force: :cascade do |t|
      t.string   "item_type",  null: false
      t.integer  "item_id",    null: false
      t.string   "event",      null: false
      t.string   "whodunnit"
      t.text     "object"
      t.datetime "created_at"
      t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
    end
  end
end
