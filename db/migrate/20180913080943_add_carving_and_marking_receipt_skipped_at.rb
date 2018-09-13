class AddCarvingAndMarkingReceiptSkippedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :carving_and_marking_receipt_skipped_at, :datetime
  end
end
