class AddFrozenToVessel < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :frozen_at, :datetime
  end
end
