class AddOfficialNoToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :official_no, :integer
  end
end
