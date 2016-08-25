class AddReferredUntilToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :referred_until, :datetime
  end
end
