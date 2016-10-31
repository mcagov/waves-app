require "rails_helper"

describe ClientSession do
  context "#create" do
    let!(:vessel) { create(:registered_vessel) }
    let!(:owner) { create(:registered_vessel).owners.first }

    context "with valid attributes" do
      before { expect(SmsProvider).to receive(:send_access_code).once }

      subject do
        ClientSession.create(
          vessel_reg_no: vessel.reg_no,
          external_session_key: "123")
      end

      it "sets the access_code" do
        expect(subject.access_code).to be_present
      end

      it "belongs to the vessel" do
        expect(subject.vessel).to eq(vessel)
      end

      it "builds the obfuscated_recipient_phone_numbers" do
        expect(subject.obfuscated_recipient_phone_numbers)
          .to eq(["********#{owner.phone_number.last(3)}"])
      end
    end

    context "with invalid attributes" do
      subject do
        ClientSession.create(
          vessel_reg_no: "foo",
          external_session_key: "")
      end

      it "does not belong to a vessel" do
        expect(subject.vessel).to be_nil
      end

      it "has an error on the external_session_key" do
        expect(subject.errors).to include(:external_session_key)
      end
    end
  end
end
