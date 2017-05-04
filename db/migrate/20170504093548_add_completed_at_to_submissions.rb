class AddCompletedAtToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :completed_at, :datetime
  end
end
