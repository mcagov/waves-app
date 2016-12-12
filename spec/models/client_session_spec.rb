require "rails_helper"

describe ClientSession do
  context "#create" do
    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:owner) { create(:registered_vessel).owners.first }

    context "with valid attributes" do
      before { expect(SmsProvider).to receive(:send_access_code).once }

      subject do
        ClientSession.create(
          vessel_reg_no: registered_vessel.reg_no,
          email: owner.email,
          external_session_key: "123")
      end

      it "sets the access_code" do
        expect(subject.access_code).to be_present
      end

      it "belongs to the registered_vessel" do
        expect(subject.registered_vessel).to eq(registered_vessel)
      end

      it "builds the obfuscated_recipient_phone_number" do
        expect(subject.obfuscated_recipient_phone_number)
          .to eq("********#{owner.phone_number.last(3)}")
      end
    end

    context "with invalid attributes" do
      subject do
        ClientSession.create(
          vessel_reg_no: "foo",
          email: "something",
          external_session_key: "")
      end

      it "does not belong to a registered_vessel" do
        expect(subject.registered_vessel).to be_nil
      end

      it "has an error on the external_session_key" do
        expect(subject.errors).to include(:external_session_key)
      end
    end
  end
end
