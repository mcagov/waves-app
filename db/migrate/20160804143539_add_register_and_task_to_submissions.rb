class AddRegisterAndTaskToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :register, :string
    add_column :submissions, :task, :string
    add_index :submissions, :register
    add_index :submissions, :task
  end
end
