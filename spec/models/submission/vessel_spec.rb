require "rails_helper"

describe Submission::Vessel, type: :model do
  context "#new" do
    let(:input_params) do
      {
        name: "A real name",
        non_existent: "rubbish"
      }
    end

    subject { Submission::Vessel.new(input_params)}

    it "has a name" do
      expect(subject.name).to eq("A real name")
    end

    it "does not have non_existent" do
      expect{ subject.non_existent }.to raise_error(NoMethodError)
    end
  end
end
