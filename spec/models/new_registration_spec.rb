require "rails_helper"

describe NewRegistration, type: :model do

  let!(:submission) { create_completeable_submission! }

  context "#process_application!" do
    before { submission.process_application!}
    let!(:vessel) { Register::Vessel.last }

    it "creates a vessel" do
      expect(vessel).to be_present
    end
  end
end
