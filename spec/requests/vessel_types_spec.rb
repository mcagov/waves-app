require "rails_helper"

describe "VesselType API" do
  VESSEL_TYPES = %w(Lorry Barge Frigate).freeze

  before do
    VESSEL_TYPES.each do |v|
      create(:vessel_type, name: v, key: v.parameterize)
    end
  end

  it "sends an ordered list of vessel types" do
    get api_v1_vessel_types_path

    expect(json.length).to eq(3)
    expect(json[0]["attributes"]["name"]).to eq("Barge")
  end
end
