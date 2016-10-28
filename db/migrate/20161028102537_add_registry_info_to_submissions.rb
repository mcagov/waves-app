class AddRegistryInfoToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :registry_info, :json
  end
end
