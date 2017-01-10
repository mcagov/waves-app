class AddRegisterTonnageToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :register_tonnage, :decimal
  end
end
