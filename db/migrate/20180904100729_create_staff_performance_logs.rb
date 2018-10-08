class CreateStaffPerformanceLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_performance_logs, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :task_id, index: true
      t.integer :activity
      t.date :target_date
      t.integer :service_level
      t.uuid :actioned_by_id
      t.timestamps
    end
  end
end
