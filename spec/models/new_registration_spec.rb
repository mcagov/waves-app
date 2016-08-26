require "rails_helper"

describe NewRegistration, type: :model do

  let!(:submission) { create_completeable_submission! }

  context "#process_application!" do
    before { submission.process_application }
    let!(:vessel) { Register::Vessel.last }

    it "creates a vessel" do
      expect(vessel).to be_present
    end

    it "creates the registered_owners" do
      expect(vessel.registered_owners.first.name).to eq("Horatio Nelson")
    end
  end
end
