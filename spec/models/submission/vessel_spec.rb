require "rails_helper"

describe Submission::Vessel do
  context "#new" do
    subject { Submission::Vessel.new(input_params) }

    context "in general" do
      let(:input_params) do
        { name: "A real name", non_existent: "rubbish" }
      end

      it "has a name" do
        expect(subject.name).to eq("A real name")
      end

      it "does not have non_existent" do
        expect { subject.non_existent }.to raise_error(NoMethodError)
      end
    end
  end

  context "#assign_attributes" do
    let!(:submission) { create_incomplete_submission! }
    let(:vessel) { submission.vessel }

    before do
      vessel.assign_attributes(name: "Jolly Fine Boat")
    end

    it "updates the vessel name" do
      expect(vessel.name).to eq("Jolly Fine Boat")
    end
  end
end
