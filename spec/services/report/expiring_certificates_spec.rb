require "rails_helper"

describe Report::ExpiringCertificates do
  context "in general" do
    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Expiring Certificates")
    end

    it "has some filter_fields" do
      expect(subject.filter_fields)
        .to eq([:filter_document_type, :filter_part, :filter_date_range])
    end

    it "has some headings" do
      headings =
        [
          :vessel_name, :part, :official_no, :certificate, :expiry_date
        ]
      expect(subject.headings).to eq(headings)
    end

    it "has a date range label" do
      expect(subject.date_range_label).to eq("Expiry Date")
    end
  end
end
