class CreateShareholderGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :shareholder_group_members, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     :shareholder_group_id
      t.uuid     :owner_id
      t.timestamps
    end
  end
end
