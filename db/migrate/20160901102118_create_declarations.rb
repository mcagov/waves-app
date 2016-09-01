class CreateDeclarations < ActiveRecord::Migration[5.0]
  def change
    create_table :declarations, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id, index: true
      t.string :state, index: true
      t.string :owner_email
      t.timestamps
    end
  end
end
