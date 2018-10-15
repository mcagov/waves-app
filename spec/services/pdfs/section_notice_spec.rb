require "rails_helper"

describe Pdfs::SectionNotice do
  context "in general" do
    let(:section_notice) do
      create(
        :section_notice,
        noteable: create(:registered_vessel),
        recipients: [%w(Alice London), %w(Bob Southampton)],
        subject: "Broke the rules")
    end

    let(:pdf) { described_class.new(section_notice, :printable) }

    it "has a filename" do
      expect(pdf.filename).to eq("section-notices.pdf")
    end

    it "has 2 pages" do
      PDF::Reader.open(StringIO.new(pdf.render)) do |reader|
        expect(reader.page_count).to eq(4)

        expect(reader.page(1).text).to include("Alice")
        expect(reader.page(1).text).to include("Broke the rules")
        expect(reader.page(2).text).to include("Of: London")

        expect(reader.page(3).text).to include("Bob")
        expect(reader.page(3).text).to include("Broke the rules")
        expect(reader.page(4).text).to include("Of: Southampton")
      end
    end
  end
end
