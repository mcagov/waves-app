class RebuildAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.attachment :file
      t.uuid :owner_id, index: true
      t.string :owner_type, index: true
      t.timestamps
    end
  end
end
