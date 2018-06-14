class RemoveTaskFromSubmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :task, :string, index: true
  end
end
