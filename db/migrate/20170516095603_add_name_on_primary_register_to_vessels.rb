class AddNameOnPrimaryRegisterToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :name_on_primary_register, :string
  end
end
