class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.uuid :vessel_id
      t.uuid :submission_id
      t.date :registered_at
      t.date :registered_until
      t.timestamps
    end
  end
end
