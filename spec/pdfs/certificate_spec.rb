require "rails_helper"

describe Certificate do
  context "for a single registration" do
    let!(:vessel) { create(:register_vessel, name: "Jolly Roger") }

    let!(:registration) do
      create(:registration, vessel: vessel, registered_at: "2012-12-03")
    end

    subject { Certificate.new(registration) }

    it "has a filename" do
      expect(subject.filename).to eq("jolly-roger-registration-2012-12-03.pdf")
    end

    it "renders a pdf" do
      expect(subject.render[0, 4]).to eq("%PDF")
    end

    it "tests the pdf has the expected elements"
  end

  context "for multiple registrations" do
    it "has multiple pages"
  end
end
