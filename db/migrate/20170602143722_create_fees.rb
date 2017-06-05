class CreateFees < ActiveRecord::Migration[5.0]
  def change
    create_table :fees, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string  :category, index: true
      t.string  :task_variant, index: true
      t.integer :price, default: 0, allow_nil: false
      t.integer :premium_addon_price, default: nil
      t.timestamps
    end
  end
end
