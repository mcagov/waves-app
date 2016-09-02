require "rails_helper"

describe "Country API" do
  before do
    1.upto(5) { create(:country) }
  end

  it "sends a list of countries" do
    get api_v1_countries_path

    expect(json.length).to eq(5)
    expect(json[0]["attributes"]["name"]).to be_present
    expect(json[0]["attributes"]["code"]).to be_present
  end
end
