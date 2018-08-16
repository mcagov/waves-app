require "rails_helper"

describe ApplicationProcessor do
  context "#run" do
    let(:service) do
      create(:service, activities: activities, print_templates: print_templates)
    end

    let(:submission) { create(:submission, :part_1_vessel) }
    let(:registered_vessel) { submission.registered_vessel }
    let(:task) { create(:task, submission: submission, service: service) }
    let(:approval_params) { {} }
    let(:activities) { [] }
    let(:print_templates) { [] }

    subject do
      described_class.run(task, approval_params)
    end

    context "activity: update_registry_details" do
      let(:approval_params) { { registration_starts_at: "01/01/2011" } }
      let(:activities) { [:update_registry_details] }

      before do
        expect(Builders::RegistryBuilder)
          .to receive(:create)
          .with(submission, approval_params)
      end

      it { subject }
    end

    context "activity: generate_new_5_year_registration" do
      let(:approval_params) do
        {
          registration_starts_at: "01/01/2011",
          registration_ends_at: "01/01/2016",
        }
      end

      let(:activities) { [:generate_new_5_year_registration] }

      before do
        expect(Builders::RegistrationBuilder)
          .to receive(:create)
          .with(
            task,
            registered_vessel, "01/01/2011", "01/01/2016", false)
      end

      it { subject }
    end

    context "activity: generate_provisional_registration" do
      let(:approval_params) do
        {
          registration_starts_at: "01/01/2011",
          registration_ends_at: "01/04/2011",
        }
      end

      let(:activities) { [:generate_provisional_registration] }

      before do
        expect(Builders::RegistrationBuilder)
          .to receive(:create)
          .with(
            task,
            registered_vessel, "01/01/2011", "01/04/2011", true)
      end

      it { subject }
    end

    context "activity: record_transcript_event" do
      let(:activities) { [:record_transcript_event] }

      before do
        expect(Builders::RegistrationBuilder)
          .to receive(:create)
          .with(
            task,
            submission.registered_vessel,
            registered_vessel.current_registration.registered_at,
            registered_vessel.current_registration.registered_until,
            registered_vessel.current_registration.provisional?)
      end

      it { subject }
    end

    context "activity: close_registration" do
      let(:approval_params) do
        {
          closure_at: "02/02/2012",
          closure_reason: "a reason",
          supporting_info: "something",
        }
      end

      let(:activities) { [:close_registration] }

      before do
        expect(Builders::ClosedRegistrationBuilder)
          .to receive(:create)
          .with(task, "02/02/2012", "a reason", "something")
      end

      it { subject }
    end

    context "print: registration_certificate, cover_letter and foo" do
      let(:print_templates) { [:cover_letter, :registration_certificate, :foo] }
      let(:registration) { create(:registration) }

      before do
        allow(submission).to receive(:registration).and_return(registration)
        subject
      end

      it "builds a cover_letter print job" do
        cover_letter = PrintJob.find_by(template: :cover_letter)
        expect(cover_letter.submission).to eq(submission)
        expect(cover_letter.printable).to eq(submission.reload.registration)
        expect(cover_letter.part).to eq(submission.part)
      end

      it "builds a registration_certificate print job" do
        expect(
          PrintJob.find_by(template: :registration_certificate)).to be_present
      end

      it "builds a foo print job" do
        expect(PrintJob.find_by(template: :foo)).to be_present
      end
    end

    context "print: csr_form" do
      let(:print_templates) { [:csr_form] }
      let(:csr_form) { create(:csr_form) }

      before do
        allow(submission).to receive(:csr_form).and_return(csr_form)
        subject
      end

      it "builds a csr_form print job" do
        expect(PrintJob.find_by(template: :csr_form).printable).to eq(csr_form)
      end
    end
  end
end
