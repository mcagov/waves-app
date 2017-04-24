require "rails_helper"

describe Pdfs::Part4::HistoricTranscript do
  context "for a single transcript" do
    let(:vessel) { create(:registered_vessel) }
    let(:transcript) do
      described_class.new(vessel.current_registration)
    end

    it "has the title HISTORIC" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page(1).text).to match(/HISTORIC TRANSCRIPT/)
      end
    end
  end
end
