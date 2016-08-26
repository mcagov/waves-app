require "rails_helper"

describe NewRegistration, type: :model do

  let!(:submission) { create_completeable_submission! }

  context "#process_application!" do
    before { submission.process_application }

    it "creates a vessel" do
      expect(submission.registered_vessel).to be_present
    end

    it "creates the registered_owners" do
      expect(submission.registered_vessel.registered_owners.length).to eq(2)
    end

    it "creates the one year registration" do
      expect(submission.registration.registered_at).to eq(Date.today)
      expect(submission.registration.registered_until).to eq(Date.today.advance days: 364)
    end
  end
end
