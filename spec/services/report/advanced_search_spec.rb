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
end
