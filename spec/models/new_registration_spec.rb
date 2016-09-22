require "rails_helper"

describe NewRegistration, type: :model do
  let!(:new_registration) { create_assigned_submission! }

  context "in general" do
    it "has a ref_no with the expected prefix" do
      expect(new_registration.ref_no).to match(/3N-.*/)
    end

    it "is called Submission::NewRegistration"
  end

  context "#process_application!" do
    before do
      expect(Builders::RegistrationBuilder)
        .to receive(:create).with(new_registration)
    end

    it { new_registration.process_application }
  end
end
