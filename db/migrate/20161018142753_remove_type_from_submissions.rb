class RemoveTypeFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :type, :string, index: true
  end
end
