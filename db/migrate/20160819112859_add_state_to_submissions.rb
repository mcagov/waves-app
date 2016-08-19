class AddStateToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :state, :string, index: true
  end
end
