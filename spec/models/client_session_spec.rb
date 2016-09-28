require "rails_helper"

describe ClientSession do
  context "#create" do
    subject do
      ClientSession.create(
        vessel_reg_no: vessel_reg_no,
        external_session_key: external_session_key)
    end

    context "with a valid vessel reg_no" do
      let!(:vessel) { create(:register_vessel) }
      let!(:owner) { create(:register_owner, vessel: vessel) }
      let(:vessel_reg_no) { vessel.reg_no }
      let(:external_session_key) { "123" }

      it "is persisted" do
        expect(subject).to be_persisted
      end

      it "sets the OTP" do
        expect(subject.otp).to be_present
      end

      it "has an initial_state :unused" do
        expect(subject).to be_unused
      end

      it "belongs to the vessel" do
        expect(subject.vessel).to eq(vessel)
      end

      it "delivers a notify message" do
        expect(Delayed::Job.count).to eq(1)
      end

      it "returns the obfuscated_recipient_phone_numbers" do
        expect(subject.obfuscated_recipient_phone_numbers)
          .to eq(["######{owner.phone_number.last(3)}"])
      end

      context "but no external_session_key" do
        let(:external_session_key) { "" }

        it "has an error on the external_session_key" do
          expect(subject.errors).to include(:external_session_key)
        end
      end
    end

    context "with an invalid vessel reg_no" do
      let(:vessel_reg_no) { "foo" }
      let(:external_session_key) { "123" }

      it "does not belong to a vessel" do
        expect(subject.vessel).to be_nil
      end
    end
  end
end
