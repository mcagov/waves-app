class AddPartFieldsToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :underlying_registry, :string
    add_column :vessels, :underlying_registry_identity_no, :string
    add_column :vessels, :underlying_registry_port, :string
    add_column :vessels, :smc_issuing_authority, :string
    add_column :vessels, :smc_auditor, :string
    add_column :vessels, :issc_issuing_authority, :string
    add_column :vessels, :issc_auditor, :string
  end
end
