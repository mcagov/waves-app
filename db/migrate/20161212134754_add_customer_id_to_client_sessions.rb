class AddCustomerIdToClientSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :client_sessions, :customer_id, :uuid, index: true
  end
end
