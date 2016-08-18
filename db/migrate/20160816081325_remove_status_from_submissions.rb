class RemoveStatusFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :status, :string
  end
end
