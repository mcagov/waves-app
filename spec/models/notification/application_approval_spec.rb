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

    let(:user) { create(:user) }

    context "in general" do
      subject do
        described_class.new(
          notifiable: submission,
          body: "A message", actioned_by: user, attachments: [])
      end

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:wysiwyg)
      end

      it "has the expected email_subject" do
        expect(subject.email_subject)
          .to match(
            /UK ship registry, reference no: #{submission.ref_no}/)
      end

      it "has additional_params" do
        expect(subject.additional_params)
          .to eq(["A message", user, []])
      end
    end

    context "with an attachment" do
      let(:pdf) { OpenStruct.new(render: :pdf_file, to_sym: true) }

      before do
        expect(Pdfs::Processor)
          .to receive(:run)
          .with(:template, registration, :attachment)
          .and_return(pdf)
      end

      subject do
        described_class.new(
          notifiable: submission, attachments: :template)
      end

      it "has the pdf as the third additional param" do
        expect(subject.additional_params[2]).to eq([:pdf_file])
      end
    end
  end
end
