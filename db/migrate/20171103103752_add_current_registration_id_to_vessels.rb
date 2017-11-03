class AddCurrentRegistrationIdToVessels < ActiveRecord::Migration[5.1]
  def change
    add_column :vessels, :current_registration_id, :uuid, default: -> { "uuid_generate_v4()" }
  end
end
