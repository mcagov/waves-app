require "rails_helper"

describe Pdfs::CoverLetter do
  context "for a single registration" do
    let(:vessel) { create(:registered_vessel) }
    let(:cover_letter) do
      described_class.new(vessel.current_registration)
    end

    it "has a filename" do
      expect(cover_letter.filename)
        .to match(/boaty-mcboatfac.*\-cover-letter-.*\.pdf/)
    end
  end

  context "for multiple registrations" do
    before { 3.times { create(:registered_vessel) } }
    let(:cover_letter) { Pdfs::CoverLetter.new(Registration.all) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to eq("cover-letters.pdf")
    end

    it "has six pages with the vessel name on 1,3,5 and reg_no on 2,4,6" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(6)
        expect(reader.page(1).text).to match(/Boaty McBoatface/)
        expect(reader.page(2).text).to match(/SSR/)
        expect(reader.page(3).text).to match(/Boaty McBoatface/)
        expect(reader.page(4).text).to match(/SSR/)
        expect(reader.page(5).text).to match(/Boaty McBoatface/)
        expect(reader.page(6).text).to match(/SSR/)
      end
    end
  end
end
