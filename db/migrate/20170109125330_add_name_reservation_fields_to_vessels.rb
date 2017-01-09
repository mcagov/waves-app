class AddNameReservationFieldsToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :registration_type, :string
    add_column :vessels, :port_code, :string, index: true
    add_column :vessels, :port_no, :integer, index: true
    add_column :vessels, :net_tonnage, :integer
    add_column :vessels, :gross_tonnage, :integer
    add_column :vessels, :name_reserved_until, :datetime
  end
end
