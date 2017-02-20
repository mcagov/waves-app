require "rails_helper"

describe Submission::DeliveryAddress do
  context ".active?" do
    let(:delivery_address) { Submission::DeliveryAddress.new }

    subject { delivery_address.active? }

    it "is not active when there are no values" do
      expect(subject).to be_falsey
    end

    context "with name, address_1 and postcode" do
      before do
        delivery_address.name = "Bob"
        delivery_address.address_1 = "10 My Street"
        delivery_address.postcode = "ABC 123"
      end

      it "is active" do
        expect(subject).to be_truthy
      end
    end
  end
end
