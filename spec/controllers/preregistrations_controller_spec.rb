require "rails_helper"

describe PreregistrationsController, type: :controller do
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

  def parameters_hash(value = nil)
    {
      preregistration: {
        not_registered_before_on_ssr: value,
        not_registered_under_part_1: value,
        owners_are_uk_residents: value,
        user_eligible_to_register: value
      }
    }
  end

  def valid_parameters
    parameters_hash("1")
  end

  def invalid_parameters
    parameters_hash("0")
  end
end
