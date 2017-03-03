class CreateNameApprovals < ActiveRecord::Migration[5.0]
  def change
    create_table :name_approvals, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id
      t.string :part, index: true
      t.string :name, index: true
      t.string :port_code, index: true
      t.integer :port_no
      t.string :registration_type
      t.datetime :approved_until
      t.timestamps
    end
  end
end
