require "rails_helper"

describe Pdfs::Part3::Certificate do
  context "for a single registration" do
    let!(:vessel) { create(:registered_vessel, name: "Jolly Roger") }
    let!(:registration) { vessel.current_registration }

    let(:certificate) { Pdfs::Part3::Certificate.new(registration, mode) }

    context "as an attachment" do
      let(:mode) { :attachment }

      it "has a filename" do
        expect(certificate.filename)
          .to match(/jolly-roger-registration-.*\.pdf/)
      end

      it "renders a pdf" do
        expect(certificate.render[0, 4]).to eq("%PDF")
      end

      it "has a paper_size" do
        expect(certificate.paper_size).to eq("A6")
      end

      describe "reading the pdf" do
        let(:io) { StringIO.new(certificate.render) }

        it "has two pages and the watermark" do
          PDF::Reader.open(StringIO.new(certificate.render)) do |reader|
            expect(reader.page_count).to eq(2)
            expect(reader.page(1).text).to match(/COPY OF ORIGINAL/)
          end
        end
      end
    end

    context "as printable" do
      let(:mode) { :printable }

      it "has one page and has the vessel name" do
        PDF::Reader.open(StringIO.new(certificate.render)) do |reader|
          expect(reader.page_count).to eq(1)
          expect(reader.page(1).text).to match(/Jolly Roger/)
        end
      end
    end
  end

  context "for multiple registrations" do
    before do
      3.times { create(:registered_vessel) }
    end

    let(:certificate) { Pdfs::Part3::Certificate.new(Registration.all) }
    let(:owners) { Registration.all.map { |r| r.owners[0] } }

    it "has a filename" do
      expect(certificate.filename)
        .to eq("certificates-of-registry.pdf")
    end

    it "has three pages with the owner name on each" do
      PDF::Reader.open(StringIO.new(certificate.render)) do |reader|
        expect(reader.page_count).to eq(3)
        expect(reader.page(1).text).to match(owners[0][:name])
        expect(reader.page(2).text).to match(owners[1][:name])
        expect(reader.page(3).text).to match(owners[2][:name])
      end
    end
  end
end
