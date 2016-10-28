require "rails_helper"

describe Builders::SubmissionBuilder do
  let!(:submission) { create(:submission) }

  context "#create" do
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

    it "builds the ref_no" do
      expect(submission.ref_no).to be_present
    end

    it "builds a declaration for each owner" do
      expect(submission.declarations.count).to eq(submission.owners.count)
    end
  end

  describe "#update" do
    it "builds the registry_infor"
    it "builds the registry_infor"
  end
end
