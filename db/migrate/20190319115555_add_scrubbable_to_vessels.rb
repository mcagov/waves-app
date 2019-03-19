class AddScrubbableToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :scrubbable, :boolean, default: false
  end
end
