require "rails_helper"

describe Pdfs::CoverLetter do
  context "for a single registration" do
    before { create(:printing_submission) }

    let(:cover_letter) { Pdfs::CoverLetter.new(Registration.last) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to match(/boaty-mcboatfac.*\-cover-letter-.*\.pdf/)
    end
  end

  context "for multiple registrations" do
    before do
      3.times { create(:printing_submission) }
    end

    let(:cover_letter) { Pdfs::CoverLetter.new(Registration.all) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to eq("cover-letters.pdf")
    end

    it "has three pages with the vessel name on each" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(3)
        expect(reader.page(1).text).to match(/BOATY MCBOATFAC/)
        expect(reader.page(2).text).to match(/BOATY MCBOATFAC/)
        expect(reader.page(3).text).to match(/BOATY MCBOATFAC/)
      end
    end
  end
end
