require "rails_helper"

describe Submission::NewRegistration, type: :model do
  let!(:new_registration) { create_assigned_submission! }

  context "in general" do
    it "has a ref_no with the expected prefix" do
      expect(new_registration.ref_no).to match(/3N-.*/)
    end
  end

  context "#process_application" do
    before do
      expect(Builders::NewRegistrationBuilder)
        .to receive(:create).with(new_registration)

      new_registration.process_application
    end

    it "has not printed the registration_certificate" do
      expect(new_registration.registration_certificate_printed?)
        .to be_falsey
    end

    it "has not printed the cover_letter" do
      expect(new_registration.cover_letter_printed?)
        .to be_falsey
    end
  end
end
