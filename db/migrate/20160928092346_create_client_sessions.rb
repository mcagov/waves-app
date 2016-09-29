class CreateClientSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_sessions, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string :external_session_key, index: true
      t.string :vessel_reg_no, index: true
      t.uuid :submission_id, index: true
      t.integer :otp
      t.timestamps
    end
  end
end
