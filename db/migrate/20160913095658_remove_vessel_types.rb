class RemoveVesselTypes < ActiveRecord::Migration[5.0]
  def change
    drop_table "vessel_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "name"
      t.string   "key"
    end
  end
end
