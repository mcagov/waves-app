class AddCorrespondentIdToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :correspondent_id, :uuid
  end
end
