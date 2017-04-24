require "rails_helper"

describe Pdfs::Part4::Transcript do
  let(:transcript_title) { "OF A BAREBOAT CHARTER SHIP" }

  context "for a single transcript" do
    let(:vessel) { create(:registered_vessel) }
    let(:transcript) do
      described_class.new(vessel.current_registration)
    end

    it "has two pages with the title on page 1" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page_count).to eq(2)
        expect(reader.page(1).text).to match(/#{transcript_title}/)
      end
    end
  end
end
