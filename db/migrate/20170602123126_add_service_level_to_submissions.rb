class AddServiceLevelToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :service_level, :string, default: :standard
    remove_column :submissions, :is_urgent, :boolean
  end
end
