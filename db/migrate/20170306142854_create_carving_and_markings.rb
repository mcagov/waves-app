class CreateCarvingAndMarkings < ActiveRecord::Migration[5.0]
  def change
    create_table :carving_and_markings, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id
      t.string :tonnage_type
      t.string :delivery_method
      t.uuid :issued_by_id
      t.timestamps
    end
  end
end
