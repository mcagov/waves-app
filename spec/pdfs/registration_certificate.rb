require "rails_helper"

describe RegistrationCertificate do
  context "in general" do
    let!(:vessel) { create(:register_vessel, name: "Jolly Roger") }

    let!(:registration) do
      create(:registration, vessel: vessel, registered_at: "2012-12-03")
    end

    subject { RegistrationCertificate.new(vessel) }

    it "has a filename" do
      expect(subject.filename).to eq("jolly-roger-registration-2012-12-03.pdf")
    end

    it "renders a pdf" do
      expect(subject.render[0, 4]).to eq("%PDF")
    end

    it "needs to render multiple certificates in one PDF"
  end
end
