require "rails_helper"

describe Pdfs::Part2::Certificate do
  context "in general" do
    let!(:vessel) { create(:registered_vessel, name: "Jolly Roger") }
    let!(:registration) { vessel.current_registration }

    let(:certificate) do
      Pdfs::Part2::Certificate.new(registration, :attachment)
    end

    it "renders a pdf" do
      expect(certificate.render[0, 4]).to eq("%PDF")
    end

    it "has a paper_size" do
      expect(certificate.paper_size).to eq("A4")
    end

    context "reading the pdf" do
      let(:io) { StringIO.new(certificate.render) }

      before do
        expect(registration).to receive(:prints_duplicate_certificate?).once
      end

      it "has the expected pages" do
        PDF::Reader.open(StringIO.new(certificate.render)) do |reader|
          expect(reader.page_count).to eq(2)
          expect(reader.page(1).text).to match(/COPY OF ORIGINAL/)
        end
      end
    end
  end
end
