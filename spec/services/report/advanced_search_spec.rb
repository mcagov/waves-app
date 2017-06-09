require "rails_helper"

describe Report::AdvancedSearch do
  context "in general" do
    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Advanced Search")
    end

    it "has the expected filter_field" do
      expect(subject.filter_fields).to eq([:filter_advanced_search])
    end

    it "has no headings by default" do
      expect(subject.headings).to eq([])
    end
  end

  context "#results" do
    let!(:named_boat) { create(:registered_vessel, name: "named_boat") }
    let(:filters) do
      { vessel: { name: { operator: operator, value: "named_b" } } }
    end

    subject { Report::AdvancedSearch.new(filters).results }

    context "with a search that includes the named_boat" do
      let(:operator) { :includes }

      it { expect(subject.length).to eq(1) }
    end

    context "with a search that excludes the named_boat" do
      let(:operator) { :excludes }

      it { expect(subject).to be_empty }
    end
  end
end
