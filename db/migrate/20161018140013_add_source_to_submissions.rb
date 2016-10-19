class AddSourceToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :source, :string
  end
end
