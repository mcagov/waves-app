class AddClaimantToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :claimant_id, :uuid, index: true
  end
end
