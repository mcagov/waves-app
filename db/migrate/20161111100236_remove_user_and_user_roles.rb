class RemoveUserAndUserRoles < ActiveRecord::Migration[5.0]
  def change
    drop_table "user_roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "user_id"
      t.uuid     "role_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    drop_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
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
  end
end
