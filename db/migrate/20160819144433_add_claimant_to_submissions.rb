class AddClaimantToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :claimant_id, :integer, index: true
  end
end
