class AddIndexToVesselsPart < ActiveRecord::Migration[5.0]
  def change
    add_index :vessels, :part
  end
end
