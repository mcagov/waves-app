class AddActivitiesAndPrintTemplatesToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :activities, :json, default: []
    add_column :services, :print_templates, :json, default: []
  end
end
