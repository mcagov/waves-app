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

  describe "#column_attributes" do
    let(:filters) do
      { vessel: { name: { result_displayed: "1" }, reg_no: {} } }
    end

    let(:criteria) { Report::AdvancedSearch::VesselCriteria.new(filters) }

    subject { criteria.column_attributes }

    it "builds the column_attributes" do
      expect(subject).to eq([:name])
    end
  end

  describe "#headings" do
    let(:criteria) { Report::AdvancedSearch::VesselCriteria.new({}) }

    before do
      allow(criteria).to receive(:column_attributes).and_return([:name])
    end

    subject { criteria.headings }

    it "builds the headings" do
      expect(subject).to eq(["Vessel Name"])
    end
  end
end
