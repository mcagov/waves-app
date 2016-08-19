require "rails_helper"

describe Submission::Vessel do
  context "#new" do
    subject { Submission::Vessel.new(input_params)}

    context "in general" do
      let(:input_params) do
        {
          name: "A real name",
          non_existent: "rubbish"
        }
      end

      it "has a name" do
        expect(subject.name).to eq("A real name")
      end

      it "does not have non_existent" do
        expect{ subject.non_existent }.to raise_error(NoMethodError)
      end
    end

    context "#type_of_vessel" do
      context "when vessel_type was chosen" do
        let(:input_params) do
          {
            vessel_type: "Barge",
            vessel_type_other: ""
          }
        end

        it "uses the vessel_type field" do
          expect(subject.type_of_vessel).to eq("Barge")
        end
      end

      context "when vessel_type_other was chosen" do
        let(:input_params) do
          {
            vessel_type: "?",
            vessel_type_other: "Beer mug"
          }
        end

        it "uses the vessel_type_other field" do
          expect(subject.type_of_vessel).to eq("Beer mug")
        end
      end
    end
  end
end
