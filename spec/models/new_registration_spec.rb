require "rails_helper"

describe NewRegistration, type: :model do

  let!(:submission) { create_completeable_submission! }

  context "#process_application!" do
    before { submission.process_application!}
    let!(:vessel) { Register::Vessel.last }

    it "creates a vessel" do
      expect(vessel).to be_present
    end

    it "creates the one year registration"

    it "fails gracefully if the vessel is not valid"
  end
end
