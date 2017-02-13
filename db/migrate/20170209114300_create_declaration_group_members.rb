class CreateDeclarationGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :declaration_group_members, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :declaration_id
      t.uuid :declaration_group_id
      t.timestamps
    end
  end
end
