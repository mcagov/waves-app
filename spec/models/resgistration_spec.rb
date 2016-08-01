require "rails_helper"

describe Registration, type: :model do
  let!(:registration) { create_registration! }

  it "sets the submission" do
    expect(registration.submission).to eq(JSON.parse(registration.changeset))
  end

  it "gets the correspondent_info" do
    expect(registration.correspondent_info).to eq(registration.submission["owner_info_1"])
  end

  it "gets the vessel_info" do
    expect(registration.vessel_info).to eq(registration.submission["vessel_info"])
  end

  it "get two owners" do
    expect(registration.owners.length).to eql(2)
  end
end
