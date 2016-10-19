require "rails_helper"

describe Builders::SubmissionBuilder do
  context "#create" do
    let!(:submission) { build_incomplete_submission! }

    subject { described_class.create(submission) }

    it "defaults to task = new_registration" do
      expect(submission.task.to_sym).to eq(:new_registration)
    end

    it "defaults to source = online" do
      expect(submission.source.to_sym).to eq(:online)
    end

    it "defaults to part = part_3" do
      expect(submission.part.to_sym).to eq(:part_3)
    end

    it "builds the ref_no with the default prefix" do
      expect(submission.ref_no).to match(/3N-.*/)
    end

    it "builds a declaration for each owner" do
      expect(submission.declarations.count).to eq(submission.owners.count)
    end
  end
end
