class CreateDeclarationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :declaration_groups, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id
      t.integer :shares_held, default: 0
      t.timestamps
    end
  end
end
