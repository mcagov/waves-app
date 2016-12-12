require "rails_helper"

describe Api::V1::VesselsController, type: :controller do
  context "#show" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

    let!(:vessel) { create(:registered_vessel) }
    let(:email) { vessel.customers.first.email }

    let!(:client_session) do
      create(:client_session,
             vessel_reg_no: vessel.reg_no,
             email: email)
    end

    let(:access_code) { client_session.access_code }
    let(:external_session_key) { client_session.external_session_key }
    let(:id) { "#{access_code};#{external_session_key}" }

    before do
      get :show, params: { id: id }
    end

    context "with a valid access_code" do
      it "sets the content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the registry_info" do
        expect(parsed_attrs["registry_info"]["vessel_info"]["name"])
          .to eq(vessel.name)
      end
    end

    context "and an invalid access_code" do
      let(:access_code) { "000000" }

      it { expect(response).to have_http_status(404) }
    end

    context "with an invalid session_key" do
      let(:external_session_key) { "foo" }

      it { expect(response).to have_http_status(404) }
    end
  end
end
