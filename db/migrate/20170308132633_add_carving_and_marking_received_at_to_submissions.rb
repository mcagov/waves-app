class AddCarvingAndMarkingReceivedAtToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :carving_and_marking_received_at, :datetime
  end
end
