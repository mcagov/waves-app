class AddChangesetToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :changeset, :json
  end
end
