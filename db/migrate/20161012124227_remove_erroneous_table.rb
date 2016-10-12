class RemoveErroneousTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :add_received_at_to_submissions
  end
end
