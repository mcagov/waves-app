class AddTerminationNoticeIssuedAtToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :termination_notice_issued_at, :datetime
  end
end
