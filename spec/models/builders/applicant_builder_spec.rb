require "rails_helper"

describe Builders::ApplicantBuilder do
  context ".build" do
    subject { described_class.build(submission) }

    context "with the expect data" do
      let(:submission) do
        Submission.new(
          changeset: {
            correspondent: correspondent,
            owners: [{
              id: :owners_1, name: "Oliver", email: "oliver@example.com" }],
            agent: { name: "Ali", email: "ali@example.com" },
            customer: { name: "Charlie", email: "charlie@example.com" } })
      end

      context "when the correspondent is :owners_1" do
        let(:correspondent) { :owners_1 }

        it { expect(subject.applicant_name).to eq("Oliver") }
        it { expect(subject.applicant_email).to eq("oliver@example.com") }
      end

      context "when the correspondent is :agent" do
        let(:correspondent) { :agent }

        it { expect(subject.applicant_name).to eq("Ali") }
        it { expect(subject.applicant_email).to eq("ali@example.com") }
      end

      context "when the correspondent is :customer" do
        let(:correspondent) { :customer }

        it { expect(subject.applicant_name).to eq("Charlie") }
        it { expect(subject.applicant_email).to eq("charlie@example.com") }
      end
    end

    context "when the correspondent has not been defined" do
      let(:submission) do
        Submission.new(
          changeset: {
            owners: [{
              id: :owners_1, name: "Oliver", email: "oliver@example.com" }],
            agent: { name: "Ali", email: "ali@example.com" } })
      end

      it { expect(subject.applicant_name).to eq("Oliver") }
      it { expect(subject.applicant_email).to eq("oliver@example.com") }
    end
  end
end
