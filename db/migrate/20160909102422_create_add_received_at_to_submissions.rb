class CreateAddReceivedAtToSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :add_received_at_to_submissions do |t|
      add_column :submissions, :received_at, :datetime
      t.timestamps
    end
  end
end
