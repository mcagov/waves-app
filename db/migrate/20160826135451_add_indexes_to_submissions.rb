class AddIndexesToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_index :submissions, :part
    add_index :submissions, :type
    add_index :submissions, :state
    add_index :submissions, :claimant_id
    add_index :submissions, :ref_no
  end
end
