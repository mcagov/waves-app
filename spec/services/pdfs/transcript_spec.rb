require "rails_helper"

describe Pdfs::Transcript do
  let(:transcript_title) { "TRANSCRIPT OF REGISTRY" }

  context "for a single transcript" do
    let(:vessel) { create(:registered_vessel) }
    let(:transcript) do
      described_class.new(vessel.current_registration)
    end

    it "has a filename" do
      expect(transcript.filename)
        .to match(/boaty-mcboatfac.*\-transcript\.pdf/)
    end

    it "has two pages with the title on page 1" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page_count).to eq(2)
        expect(reader.page(1).text).to match(/#{transcript_title}/)
      end
    end
  end

  context "for multiple transcripts" do
    before { 3.times { create(:registered_vessel) } }
    let(:transcript) { described_class.new(Registration.all) }

    it "has a filename" do
      expect(transcript.filename)
        .to eq("transcripts.pdf")
    end

    it "has six pages with the title on page 1,3,5" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page_count).to eq(6)
        expect(reader.page(1).text).to match(/#{transcript_title}/)
        expect(reader.page(3).text).to match(/#{transcript_title}/)
        expect(reader.page(5).text).to match(/#{transcript_title}/)
      end
    end
  end
end
