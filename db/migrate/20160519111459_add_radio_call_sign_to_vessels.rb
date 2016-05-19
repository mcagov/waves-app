class AddRadioCallSignToVessels < ActiveRecord::Migration
  def change
    add_column :vessels, :radio_call_sign, :string, null: false
  end
end
