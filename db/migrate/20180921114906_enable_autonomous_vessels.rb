class EnableAutonomousVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :autonomous_vessel, :boolean, default: false
  end
end
