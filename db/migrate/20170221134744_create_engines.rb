class CreateEngines < ActiveRecord::Migration[5.0]
  def change
    create_table :engines, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :parent_id
      t.string :parent_type, index: true
      t.string :engine_type
      t.string :make
      t.string :model
      t.integer :cylinders
      t.string :derating
      t.integer :rpm
      t.decimal :mcep_per_engine
      t.decimal :mcep_after_derating
      t.integer :quantity
      t.timestamps
    end
  end
end
