require "rails_helper"

describe Pdfs::Extended::CoverLetter do
  context "for a single registration" do
    let(:vessel) { create(:registered_vessel) }
    let(:cover_letter) do
      described_class.new(vessel.current_registration)
    end

    it "has a filename" do
      expect(cover_letter.filename)
        .to match(/registered-boat.*\-cover-letter-.*\.pdf/)
    end

    it "has one page" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(1)
        expect(reader.page(1).text).to include("I enclose the certificate")
      end
    end
  end

  context "for multiple registrations" do
    before { 3.times { create(:registered_vessel) } }
    let(:cover_letter) { Pdfs::Extended::CoverLetter.new(Registration.all) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to eq("cover-letters.pdf")
    end

    it "has three pages" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(3)
      end
    end
  end

  context "for a fishing vessel" do
    let(:vessel) { create(:fishing_vessel) }
    let(:cover_letter) do
      described_class.new(vessel.current_registration)
    end

    it "has three pages" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(2)
        expect(reader.page(2).text).to include("Training for the Crew")
      end
    end
  end
end
