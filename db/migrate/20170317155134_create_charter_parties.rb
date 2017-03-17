class CreateCharterParties < ActiveRecord::Migration[5.0]
  def change
    create_table :charter_parties, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid    :charterer_id
      t.string  :name
      t.string  :address
      t.string  :contact_details
      t.timestamps
    end
  end
end
