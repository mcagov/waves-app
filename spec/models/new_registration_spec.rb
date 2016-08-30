require "rails_helper"

describe NewRegistration, type: :model do

  let!(:new_registration) { create_completeable_submission! }

  context "in general" do
    it "has a ref_no with the expected prefix" do
      expect(new_registration.ref_no).to match(/3N-.*/)
    end
  end

  context "#process_application!" do
    before { new_registration.process_application }

    it "creates a vessel" do
      expect(new_registration.registered_vessel).to be_present
    end

    it "creates the registered_owners" do
      expect(new_registration.registered_vessel.registered_owners.length).to eq(2)
    end

    it "creates the one year registration" do
      expect(new_registration.registration.registered_at).to eq(Date.today)
      expect(new_registration.registration.registered_until).to eq(Date.today.advance days: 364)
    end
  end
end
