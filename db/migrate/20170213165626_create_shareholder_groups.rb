class CreateShareholderGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :shareholder_groups, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     :vessel_id
      t.integer  :shares_held
      t.timestamps
    end
  end
end
