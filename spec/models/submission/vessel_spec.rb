require "rails_helper"

describe Submission::Vessel do
  context "in general" do
    subject { described_class.new(input_params) }

    context "#new" do
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

    context "#type_of_vessel" do
      context "vessel_type_other" do
        let(:input_params) { { vessel_type_other: "MUG" } }

        it "uses the vessel_type_other" do
          expect(subject.type_of_vessel).to eq("MUG")
        end
      end

      context "vessel_type" do
        let(:input_params) do
          { vessel_type: "BARGE", vessel_type_other: "" }
        end

        it "uses the vessel_type" do
          expect(subject.type_of_vessel).to eq("BARGE")
        end
      end
    end
  end

  context "#assign_attributes" do
    let!(:submission) { create(:incomplete_submission) }
    let(:vessel) { submission.vessel }

    before do
      vessel.assign_attributes(name: "Jolly Fine Boat")
    end

    it "updates the vessel name" do
      expect(vessel.name).to eq("Jolly Fine Boat")
    end
  end
end
