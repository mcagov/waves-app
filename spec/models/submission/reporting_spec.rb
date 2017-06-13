require "rails_helper"

describe Submission::Reporting do
  describe "flag_in/out" do
    let!(:new_reg) { create(:submission, task: :new_registration) }
    let!(:closure) { create(:assigned_closure_submission) }

    context ".flag_in" do
      subject { Submission.flag_in }

      it "retrieves the new registration" do
        expect(subject.first).to eq(new_reg)
      end
    end

    context ".flag_out" do
      subject { Submission.flag_out }

      it "retrieves the closure" do
        expect(subject.first).to eq(closure)
      end
    end
  end
end
