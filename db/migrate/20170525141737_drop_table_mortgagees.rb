class DropTableMortgagees < ActiveRecord::Migration[5.0]
  def change
    drop_table "mortgagees", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "mortgage_id"
      t.string   "name"
      t.string   "address"
      t.string   "contact_details"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end
  end
end
