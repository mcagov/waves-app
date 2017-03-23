require "rails_helper"

describe Builders::CsrIssueNumberBuilder do
  context "#build" do
    let!(:vessel) { create(:registered_vessel, part: :part_1) }

    let!(:submission) do
      create(
        :assigned_submission,
        task: :issue_csr,
        part: :part_1,
        registered_vessel: vessel)
    end

    let!(:csr_form) do
      create(
        :csr_form,
        submission: submission,
        registered_vessel: vessel)
    end

    subject { described_class.build(submission) }

    context "when there are no csr_forms for that vessel" do
      it "builds the first issue_number" do
        expect(subject.csr_form.issue_number).to eq(1)
      end
    end

    context "when that vessel has previous csr_forms" do
      before do
        create(:csr_form, registered_vessel: vessel, issue_number: nil)
        create(:csr_form, registered_vessel: vessel, issue_number: 99)
      end

      it "builds the expected issue_number" do
        expect(subject.reload.csr_form.issue_number).to eq(100)
      end
    end
  end
end
