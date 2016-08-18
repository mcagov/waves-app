class RemoveOfficialNoFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :official_no, :integer
  end
end
