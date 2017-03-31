require "rails_helper"

describe Builders::ClonedRegistrationBuilder do
  context ".create" do
    let!(:registered_vessel) { create(:registered_vessel, name: "NEW NAME") }

    let!(:old_registration) do
      create(:registration,
             vessel_id: registered_vessel.id,
             registered_at: 1.year.ago, registered_until: 4.years.from_now,
             registry_info: { vessel_info: { name: "OLD NAME" } })
    end

    let!(:submission) do
      create(:submission,
             registered_vessel: registered_vessel, task: :manual_override)
    end

    let!(:cloned_registration) { described_class.create(submission) }

    it "assigns the submission#registration" do
      expect(submission.reload.registration).to eq(cloned_registration)
    end

    it "updates the registry_info for the current_registration" do
      expect(registered_vessel.reload.current_registration.vessel.name)
        .to eq("NEW NAME")
    end
  end

  context "when the registered vessel is not registered" do
    let!(:unregistered_vessel) { create(:unregistered_vessel) }

    let!(:submission) do
      create(:submission,
             registered_vessel: unregistered_vessel, task: :manual_override)
    end

    it { expect(described_class.create(submission)).to be_nil }
  end
end
