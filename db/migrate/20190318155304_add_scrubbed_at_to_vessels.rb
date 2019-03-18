class AddScrubbedAtToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :scrubbed_at, :datetime
    add_column :vessels, :scrubbed_by_id, :uuid
  end
end
