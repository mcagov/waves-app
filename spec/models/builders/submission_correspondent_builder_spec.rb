require "rails_helper"

describe Builders::SubmissionCorrespondentBuilder do
  let!(:submission) { create(:submission) }

  let!(:correspondent) do
    Submission::Correspondent
      .create(changeset: { name: "Bob", email: "bob@example.com" })
  end

  context ".create" do
    before { described_class.create(submission, correspondent) }

    it { expect(submission.correspondent).to eq(correspondent) }
    it { expect(submission.applicant_name).to eq(correspondent.name) }
    it { expect(submission.applicant_email).to eq(correspondent.email) }
  end
end
