require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create_incomplete_submission! }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "get two declarations" do
      expect(submission.declarations.length).to eql(2)
    end

    it "has a state: incomplete" do
      expect(submission).to be_incomplete
    end

    it "has a ref_no with the expected prefix" do
      expect(submission.ref_no).to match(/3N-.*/)
    end

    it "has some declarations" do
      expect(submission.declarations).not_to be_empty
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end
  end

  context "initializing a new_submission" do
    let!(:submission) { create_incomplete_submission! }

    it "has one completed declaration" do
      expect(submission.declarations.completed.length).to eq(1)
    end

    it "has one incomplete declaration" do
      expect(submission.declarations.incomplete.length).to eq(1)
    end

    it "does not build a notification for the completed declaration" do
      expect(submission.declarations.completed.first.notification).to be_nil
    end

    it "builds a notification for the incomplete declaration" do
      expect(submission.declarations.incomplete.first.notification)
        .to be_a(Notification::OutstandingDeclaration)
    end
  end

  context ".referred_until_expired" do
    let!(:submission) { create(:submission, referred_until: referred_until) }
    let(:submissions) { Submission.referred_until_expired }

    context "tomorrow" do
      let(:referred_until) { Date.tomorrow }
      it { expect(submissions).to be_empty }
    end

    context "today" do
      let(:referred_until) { Date.today }
      it { expect(submissions.length).to eq(1) }
    end

    context "yesterday" do
      let(:referred_until) { Date.yesterday }
      it { expect(submissions.length).to eq(1) }
    end

    context "nil" do
      let(:referred_until) { nil }
      it { expect(submissions).to be_empty }
    end
  end

  context "#process_application" do
    let!(:submission) { create_assigned_submission! }

    before do
      expect(Builders::NewRegistrationBuilder)
        .to receive(:create)
        .with(submission, "12/12/2020 11:59 AM".to_datetime)

      submission.process_application("12/12/2020 11:59 AM")
    end

    it "has not printed the registration_certificate" do
      expect(submission.printed?(:registration_certificate))
        .to be_falsey
    end

    it "has not printed the cover_letter" do
      expect(submission.printed?(:cover_letter))
        .to be_falsey
    end
  end

  context "#update_print_job" do
    let!(:submission) { create_printing_submission! }

    context "printing the registration_certificate" do
      before do
        submission.update_print_job!(:registration_certificate)
      end

      it "has printed the registration_certificate" do
        expect(submission.printed?(:registration_certificate))
          .to be_truthy
      end

      it "has the state printing" do
        expect(submission).to be_printing
      end

      context "printing the cover_letter" do
        before do
          submission.update_print_job!(:cover_letter)
        end

        it "has the state completed" do
          expect(submission).to be_completed
        end
      end
    end
  end
end
