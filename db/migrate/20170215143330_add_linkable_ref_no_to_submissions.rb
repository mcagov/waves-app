class AddLinkableRefNoToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :linkable_ref_no, :string
  end
end
