require "rails_helper"

describe ScrubbableVessels do
  let!(:vessel) do
    create(
      :registered_vessel,
      scrubbed_at: scrubbed_at,
      scrubbable: scrubbable,
      mortgages: [
        build(:mortgage, :registered, discharged_at: 10.years.ago),
        build(:mortgage, :registered, discharged_at: discharged_at)])
  end

  let(:scrubbed_at) { false }
  let(:scrubbable) { false }
  let(:discharged_at) { 8.years.ago }
  let(:registered_until) { 8.years.ago }

  before do
    vessel.current_registration.update(registered_until: registered_until)
    described_class.assign
    vessel.reload
  end

  context "in general" do
    it { expect(vessel).to be_scrubbable }
  end

  context "when it has already been scrubbed" do
    let!(:scrubbed_at) { 1.day.ago }

    it { expect(vessel).not_to be_scrubbable }
  end

  context "when it is already scrubbable" do
    let!(:scrubbable) { true }

    it { expect(vessel).to be_scrubbable }
  end

  context "when the registration did not expire 7 years ago" do
    let!(:registered_until) { 6.years.ago }

    it { expect(vessel).not_to be_scrubbable }
  end

  context "when the latest mortgage was not discharged 7 years ago" do
    let!(:discharged_at) { 6.years.ago }

    it { expect(vessel).not_to be_scrubbable }
  end

  context "when the latest mortgage has not been discharged" do
    let!(:discharged_at) { nil }

    it { expect(vessel).not_to be_scrubbable }
  end
end
