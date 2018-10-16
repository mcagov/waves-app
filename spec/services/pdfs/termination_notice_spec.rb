require "rails_helper"

describe Pdfs::TerminationNotice do
  context "in general" do
    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:section_notice) do
      create(
        :section_notice,
        noteable: registered_vessel,
        created_at: 1.day.ago,
        recipients: [%w(Alice London), %w(Bob Southampton)],
        subject: "Broke the rules")
    end

    let!(:termination_notice) do
      create(
        :termination_notice,
        noteable: registered_vessel,
        recipients: [%w(Alice London), %w(Bob Southampton)])
    end

    let(:pdf) { described_class.new(termination_notice, :printable) }

    it "has a filename" do
      expect(pdf.filename).to eq("section-notices.pdf")
    end

    it "has 2 pages" do
      PDF::Reader.open(StringIO.new(pdf.render)) do |reader|
        expect(reader.page_count).to eq(12)

        expect(reader.page(1).text).to include("Alice")
        expect(reader.page(3).text).to include("Broke the rules")
        expect(reader.page(4).text).to include("Of: London")

        expect(reader.page(5).text).to include("Bob")
        expect(reader.page(11).text).to include("Broke the rules")
      end
    end
  end
end
