class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id
      t.uuid :fee_id
      t.integer :price
      t.integer :premium_addon_price
      t.timestamps
    end
  end
end
