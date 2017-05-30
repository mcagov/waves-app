require "rails_helper"

describe Api::V1::VesselsController, type: :controller do
  context "#index" do
    let!(:vessel) { create(:registered_vessel) }

    before do
      expect(Search)
        .to receive(:vessels)
        .with("bob")
        .and_return([vessel])

      get :index, params: { filter: { q: "bob" } }
    end

    it "returns the search results as a list of vessels" do
      expect(JSON.parse(response.body)["data"].first["id"]).to eq(vessel.id)
    end
  end

  context "#show by access_code" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }
    let(:registered_vessel) { build(:registered_vessel) }

    let(:access_code) { "123456" }
    let(:external_session_key) { "an_external_session_key" }

    let(:id) { "#{access_code};#{external_session_key}" }

    before do
      allow(ClientSession)
        .to receive(:find_by)
        .with(
          access_code: access_code,
          external_session_key: external_session_key
        )
        .and_return(client_session)

      get :show, params: { id: id }
    end

    context "when the client_session is found" do
      let(:client_session) do
        double(:client_session, registered_vessel: registered_vessel)
      end

      it "sets the content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the registry_info" do
        expect(parsed_attrs["registry_info"]["vessel_info"]["name"])
          .to eq(registered_vessel.name)
      end
    end

    context "when the client_session is not found" do
      let(:client_session) { nil }

      it { expect(response).to have_http_status(404) }
    end
  end

  context "#show by reg_no" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }
    let(:registered_vessel) { create(:registered_vessel) }

    before { get :show, params: { id: 1, filter: { reg_no: reg_no } } }

    context "when the vessel is found" do
      let(:reg_no) { registered_vessel.reg_no }

      it "sets the content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the registry_info" do
        expect(parsed_attrs["registry_info"]["vessel_info"]["name"])
          .to eq(registered_vessel.name)
      end

      it "returns the registration_status" do
        expect(parsed_attrs["registration_status"].to_sym)
          .to eq(registered_vessel.registration_status.to_json)
      end
    end

    context "when the client_session is not found" do
      let(:reg_no) { "foo" }

      it { expect(response).to have_http_status(404) }
    end
  end
end
