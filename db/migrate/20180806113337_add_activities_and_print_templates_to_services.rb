class AddActivitiesAndPrintTemplatesToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :activities, :json
    add_column :services, :print_templates, :json
  end
end
