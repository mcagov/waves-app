require "rails_helper"

describe Report::AdvancedSearch::VesselCriteria do
  describe ".translation_for" do
    subject { Report::AdvancedSearch::VesselCriteria.translation_for(attr) }

    context "with a valid attribute" do
      let(:attr) { :name }

      it { expect(subject).to eq("Vessel Name") }
    end

    context "with an invalid attribute" do
      let(:attr) { :foo }

      it { expect(subject).to be_nil }
    end
  end
end
