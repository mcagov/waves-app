class AddMmsiNumberToVessels < ActiveRecord::Migration
  def change
    add_column :vessels,
               :mmsi_number,
               :integer,
               in: 1..999_999_999,
               null: false
  end
end
