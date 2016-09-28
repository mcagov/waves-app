require "rails_helper"

describe ClientSession do
  context "#create" do
    let!(:vessel) { create(:register_vessel) }
    let!(:owner) { create(:register_owner, vessel: vessel) }

    subject do
      ClientSession.create(
        vessel_reg_no: vessel_reg_no,
        external_session_key: external_session_key)
    end

    context "with valid attributes" do
      let(:vessel_reg_no) { vessel.reg_no }
      let(:external_session_key) { "123" }

      it "is persisted" do
        expect(subject).to be_persisted
      end

      it "sets the OTP" do
        expect(subject.otp).to be_present
      end

      it "belongs to the vessel" do
        expect(subject.vessel).to eq(vessel)
      end

      it "returns the obfuscated_recipient_phone_numbers" do
        expect(subject.obfuscated_recipient_phone_numbers)
          .to eq(["######{owner.phone_number.last(3)}"])
      end
    end

    context "with invalid attributes" do
      let(:vessel_reg_no) { "foo" }
      let(:external_session_key) { "" }

      it "does not belong to a vessel" do
        expect(subject.vessel).to be_nil
      end

      it "has an error on the external_session_key" do
        expect(subject.errors).to include(:external_session_key)
      end
    end
  end
end
