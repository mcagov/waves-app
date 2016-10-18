require "rails_helper"

describe Builders::SubmissionBuilder do
  context "#create" do
    let!(:submission) { build_incomplete_submission! }

    subject { described_class.create(submission) }

    it "builds the ref_no with the expected prefix" do
      expect(submission.ref_no).to match(/3N-.*/)
    end

    it "builds two declarations" do
      expect(submission.declarations.count).to eq(2)
    end

    it "is a new registration" do
      expect(submission.task.to_sym).to eq(:new_registration)
    end
  end
end
