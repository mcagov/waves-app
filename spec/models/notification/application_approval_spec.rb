require "rails_helper"

describe Notification::ApplicationApproval, type: :model do
  context "in general" do
    let!(:registered_vessel) { create(:registered_vessel) }

    let!(:registration) do
      create(:registration,
             registry_info: registered_vessel.registry_info,
             vessel_id: registered_vessel.id)
    end

    let!(:submission) do
      create(:submission,
             registration: registration,
             registered_vessel: registered_vessel)
    end

    context "in general" do
      subject { described_class.new(notifiable: submission) }

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:application_approval)
      end

      it "has the expected email_subject" do
        expect(subject.email_subject)
          .to match(
            /UK ship registry, reference no: #{submission.ref_no}/)
      end

      it "has additional_params" do
        expect(subject.additional_params)
          .to eq(
            [
              registered_vessel.reg_no,
              subject.actioned_by, "new_registration",
              registered_vessel.name, nil])
      end
    end

    context "with an attachment" do
      before do
        processor = double(:processor)

        expect(Pdfs::Processor)
          .to receive(:run)
          .with(:template, registration, :attachment)
          .and_return(processor)

        expect(processor).to receive(:render).and_return(:pdf)
      end

      subject do
        described_class.new(notifiable: submission, attachments: :template)
      end

      it "has the pdf as the fifth additional param" do
        expect(subject.additional_params[4][0, 4].to_sym).to eq(:pdf)
      end
    end
  end

  context "for a name reservation, it unsets vessel#name_registered_until"
end
