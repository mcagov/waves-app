require "rails_helper"

describe Api::V1::VesselsController, type: :controller do
  context "#show" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

    let!(:vessel) { create(:registered_vessel) }
    let!(:client_session) { create(:client_session, vessel: vessel) }
    let(:external_session_key) { client_session.external_session_key }

    let(:id) { "#{vessel_reg_no};#{access_code};#{external_session_key}" }

    before do
      get :show, params: { id: id }
    end

    context "with a valid vessel reg_no" do
      let(:vessel_reg_no) { vessel.reg_no }

      context "and a valid access_code" do
        let(:access_code) { client_session.access_code }

        it "sets the content type" do
          expect(response.content_type).to eq("application/json")
        end

        it "returns the registry-info" do
          expect(parsed_attrs["registry-info"]["vessel-info"]["name"])
            .to eq(vessel.name)
        end
      end

      context "and an invalid access_code" do
        let(:access_code) { "000000" }

        it { expect(response).to have_http_status(404) }
      end
    end

    context "with an invalid vessel reg_no" do
      let(:vessel_reg_no) { "foo" }
      let(:access_code) { client_session.access_code }

      it { expect(response).to have_http_status(404) }
    end
  end
end
