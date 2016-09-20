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

    context "#vessel_type" do
      context "when vessel_type was chosen" do
        let(:input_params) do
          { vessel_type: "Barge", vessel_type_other: "" }
        end

        it "uses the vessel_type field" do
          expect(subject.vessel_type).to eq("Barge")
        end
      end

      context "when vessel_type_other was chosen" do
        let(:input_params) do
          { vessel_type: "", vessel_type_other: "Beer mug" }
        end

        it "uses the vessel_type_other field" do
          expect(subject.vessel_type).to eq("Beer mug")
        end
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
