require "rails_helper"

describe Notification::CarvingAndMarkingReminder, type: :model do
  let!(:submission) { create(:submission, :part_1_vessel) }
  let(:notification) { described_class.new(notifiable: submission) }

  it "has the additional_params" do
    expect(notification.additional_params)
      .to eq([submission.vessel_name, submission.vessel_reg_no])
  end

  it "has the email_subject" do
    expect(notification.email_subject)
      .to match(/Carving & Marking Reminder: Boaty McBoatface [0-9]/)
  end
end
