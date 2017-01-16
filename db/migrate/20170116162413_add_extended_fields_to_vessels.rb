class AddExtendedFieldsToVessels < ActiveRecord::Migration[5.0]
  def change
    # Identity section
    add_column :vessels, :vessel_category, :string
    add_column :vessels, :imo_number, :string
    add_column :vessels, :ec_number, :string
    add_column :vessels, :last_registry_country, :string
    add_column :vessels, :last_registry_no, :string
    add_column :vessels, :last_registry_port, :string

    # Operational Information section
    add_column :vessels, :classification_society, :string
    add_column :vessels, :classification_society_other, :string
    add_column :vessels, :entry_into_service_at, :datetime
    add_column :vessels, :area_of_operation, :string
    add_column :vessels, :alternative_activity, :string

    # Description section
    add_column :vessels, :register_length, :string
    add_column :vessels, :length_overall, :string
    add_column :vessels, :breadth, :string
    add_column :vessels, :depth, :string
    add_column :vessels, :propulsion_system, :string

    # Construction section
    add_column :vessels, :name_of_builder, :string
    add_column :vessels, :builders_address, :string
    add_column :vessels, :place_of_build, :string
    add_column :vessels, :keel_laying_date, :datetime
    add_column :vessels, :hull_construction_material, :string
    add_column :vessels, :yard_number, :string
  end
end
