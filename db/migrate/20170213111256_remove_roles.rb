class RemoveRoles < ActiveRecord::Migration[5.0]
  def change
    drop_table "roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   "name",       null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
