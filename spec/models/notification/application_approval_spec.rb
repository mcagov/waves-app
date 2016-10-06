require "rails_helper"

describe Notification::ApplicationApproval, type: :model do
  context "in general" do
    let!(:register_vessel) { create(:register_vessel) }
    let!(:submission) { create(:submission) }
    let!(:registration) do
      create(:registration,
             vessel: register_vessel, submission: submission)
    end

    context "in general" do
      subject { described_class.new(notifiable: submission) }

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:application_approval)
      end

      it "has the expected email_subject" do
        expect(subject.email_subject).to eq("Application Approved")
      end

      it "has additional_params" do
        expect(subject.additional_params)
          .to eq([register_vessel.reg_no, nil])
      end
    end

    context "attaching the certificate" do
      subject do
        described_class.new(
          notifiable: submission, attachments: "registration_certificate")
      end

      it "has the certificate as the second additional param" do
        expect(subject.additional_params[1][0, 4]).to eq("%PDF")
      end
    end
  end
end
