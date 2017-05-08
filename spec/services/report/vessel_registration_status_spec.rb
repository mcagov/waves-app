require "rails_helper"

describe Report::VesselRegistrationStatus do
  context "in general" do
    let(:filters) { { task: :new_registration } }

    subject { described_class.new(filters) }

    it "has a title" do
      expect(subject.title).to eq("Vessel Registration Status")
    end

    it "has some filter_fields" do
      expect(subject.filter_fields)
        .to eq([:filter_part, :filter_date_range])
    end

    it "has some headings" do
      headings =
        [
          :vessel_name, :official_no, :radio_call_sign,
          :expiration_date, :registration_status
        ]
      expect(subject.headings).to eq(headings)
    end

    it "has a date range label" do
      expect(subject.date_range_label).to eq("Expiration Date")
    end
  end
end
