class AddRefNoToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :ref_no, :string
  end
end
