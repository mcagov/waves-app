class AddRulesToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :rules, :json
  end
end
