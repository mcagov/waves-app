require "rails_helper"

describe ClientSessionSerializer, type: :serializer do
  let!(:customer) { create(:registered_owner, phone_number: "123456789") }

  let!(:vessel) do
    create(:registered_vessel, reg_no: "REG_NO", owners: [customer])
  end

  let(:client_session) do
    build(:client_session, customer_id: customer.id, vessel_reg_no: "REG_NO")
  end

  context "attributes" do
    subject { ClientSessionSerializer.new(client_session).as_json }

    it { expect(subject[:delivered_to]).to eq("********789") }
    it { expect(subject[:customer_id]).to eq(customer.id) }
  end
end
