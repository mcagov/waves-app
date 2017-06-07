class UpdateVesselDatatypes < ActiveRecord::Migration[5.0]
  def change
    remove_column :vessels, :register_length, :string
    remove_column :vessels, :length_overall, :string
    remove_column :vessels, :breadth, :string
    remove_column :vessels, :depth, :string

    add_column :vessels, :register_length, :decimal
    add_column :vessels, :length_overall, :decimal
    add_column :vessels, :breadth, :decimal
    add_column :vessels, :depth, :decimal
  end
end
