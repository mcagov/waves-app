require "rails_helper"

describe Notification::ApplicationApproval, type: :model do
  context "in general" do
    let!(:registered_vessel) { create(:registered_vessel) }

    let!(:submission) do
      create(:submission, registered_vessel: registered_vessel)
    end

    let!(:registration) do
      create(:registration,
             registry_info: registered_vessel.registry_info,
             vessel_id: registered_vessel.id,
             submission_ref_no: submission.ref_no)
    end

    context "in general" do
      subject { described_class.new(notifiable: submission) }

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:application_approval)
      end

      it "has the expected email_subject" do
        expect(subject.email_subject)
          .to match(/Application Approved: Boaty McBoatface.* - SSR2.*/)
      end

      it "has additional_params" do
        expect(subject.additional_params)
          .to eq([registered_vessel.reg_no, subject.actioned_by, nil])
      end
    end

    context "attaching the certificate" do
      subject do
        described_class.new(
          notifiable: submission, attachments: "registration_certificate")
      end

      it "has the certificate as the third additional param" do
        expect(subject.additional_params[2][0, 4]).to eq("%PDF")
      end
    end
  end
end
