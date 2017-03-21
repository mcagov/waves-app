require "rails_helper"

describe Builders::CsrFormBuilder do
  context "#build" do
    let(:registered_vessel) { create(:registered_vessel, part: 1) }
    let(:submission) do
      create(:assigned_submission, task: :issue_csr,
                                   part: :part_1,
                                   registered_vessel: registered_vessel)
    end

    subject { described_class.build(submission) }

    context "with an existing CsrForm" do
      let!(:submission_csr_form) { create(:csr_form, submission: submission) }

      it "retrieves the existing CsrForm" do
        expect(subject).to eq(submission_csr_form)
      end
    end
  end
end
