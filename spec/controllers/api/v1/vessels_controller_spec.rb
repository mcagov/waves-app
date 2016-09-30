require "rails_helper"

describe Api::V1::VesselsController, type: :controller do
  context "#show" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }
    let(:vessel) { create(:register_vessel) }

    before do
      get :show, params: { id: vessel_reg_no }
    end

    context "with a valid vessel id" do
      let(:vessel_reg_no) { vessel.reg_no }

      it "sets the content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the vessel" do
        expect(parsed_attrs["name"]).to eq(vessel.name)
      end
    end

    context "with an invalid vessel id" do
      let(:vessel_reg_no) { "foo" }
      it { expect(response).to have_http_status(404) }
    end
  end
end
