require "rails_helper"

describe PreregistrationsController, type: :controller do
  include PreregistrationsMixin

  describe "#create" do
    context "when the preregistration parameters are valid" do
      it "responds with a success status" do
        post :create, valid_parameters
        expect(response.status).to eq(200)
      end
    end

    context "when the preregistration parameters are invalid" do
      it "redirects to the #new view" do
        post :create, invalid_parameters
        expect(response).to render_template(:new)
      end
    end
  end

  def valid_parameters
    {
      preregistration: preregistration_parameters_hash("1")
    }
  end

  def invalid_parameters
    {
      preregistration: preregistration_parameters_hash
    }
  end
end
