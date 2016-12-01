class CreateWorkLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :work_logs, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :submission_id, index: true
      t.json :logged_info
      t.string :logged_type, index: true
      t.string :description
      t.uuid :actioned_by_id, index: true
      t.timestamps
    end
  end
end
