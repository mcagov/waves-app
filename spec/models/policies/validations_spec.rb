require "rails_helper"

describe Policies::Validations do
  describe ".errors" do
    subject { described_class.new(task).errors }

    context "default state" do
      let(:task) { build(:task) }

      it { expect(subject).to be_empty }
    end

    context "for a service that validates_on_approval" do
      let(:task) do
        build(:task,
              submission: submission,
              service: create(:service, :validates_on_approval))
      end

      context "when the vessel name is blank" do
        let(:submission) { build(:submission, changeset: {}) }

        it { expect(subject).to include(:vessel_required) }
      end

      context "when there are no owners" do
        let(:submission) { build(:submission, changeset: {}) }

        it { expect(subject).to include(:owners_required) }
      end

      context "when the vessel is frozen" do
        let(:vessel) { create(:registered_vessel, frozen_at: 1.day.ago) }
        let(:submission) { create(:submission, vessel_reg_no: vessel.reg_no) }

        it { expect(subject).to include(:vessel_frozen) }
      end

      context "when shareholding is incomplete" do
        let(:submission) { create(:submission, part: :part_1) }

        it { expect(subject).to include(:shareholding_count) }
      end

      context "when the correspondent is blank" do
        let(:submission) { create(:submission, part: :part_1) }

        it { expect(subject).to include(:correspondent_required) }
      end

      context "HIN" do
        let(:submission) do
          build(:submission, changeset: { vessel_info: { hin: hin } })
        end

        context "is blank" do
          let(:hin) { "" }

          it { expect(subject).not_to include(:hin_invalid) }
        end

        context "is invalid" do
          let(:hin) { "foo" }

          it { expect(subject).to include(:hin_invalid) }
        end

        context "is valid" do
          let(:hin) { "NL-HXAB7A33G293" }

          it { expect(subject).not_to include(:hin_invalid) }
        end

        context "is valid" do
          let(:hin) { "HXAB7A33G293" }

          it { expect(subject).not_to include(:hin_invalid) }
        end
      end

      context "Radio Call sign" do
        let(:submission) do
          build(
            :submission,
            changeset: { vessel_info: { radio_call_sign: radio_call_sign } })
        end

        context "is blank" do
          let(:radio_call_sign) { "" }

          it { expect(subject).not_to include(:radio_call_sign_invalid) }
        end

        context "is invalid" do
          let(:radio_call_sign) { "foo" }

          it { expect(subject).to include(:radio_call_sign_invalid) }
        end

        context "is valid" do
          let(:radio_call_sign) { "123A" }

          it { expect(subject).not_to include(:radio_call_sign_invalid) }
        end

        context "is valid" do
          let(:radio_call_sign) { "123AB" }

          it { expect(subject).not_to include(:radio_call_sign_invalid) }
        end
      end
    end

    context "for a service that requires declarations" do
      let(:task) do
        create(:task,
               submission: create(:submission,
                                  declarations: [create(:declaration)]),
               service: create(:service, :declarations_required))
      end

      it { expect(subject).to include(:declarations_required) }
    end

    context "carving_and_marking_required" do
      let(:task) do
        create(:task,
               submission: submission,
               service: create(:service, :carving_and_marking_required))
      end

      context "part_3" do
        let(:submission) { create(:submission) }

        it { expect(subject).to be_empty }
      end

      context "default" do
        let(:submission) { create(:submission, part: :part_1) }

        it { expect(subject).to include(:carving_marking_not_issued) }
      end

      context "when the carving_and_marking has not been received" do
        let(:submission) do
          create(:submission,
                 part: :part_1,
                 carving_and_markings: [build(:carving_and_marking)])
        end

        it { expect(subject).to include(:carving_marking_not_received) }

        context "when the carving_and_marking has been received" do
          before do
            submission.update_attribute(
              :carving_and_marking_received_at, 1.day.ago)
          end

          it { expect(subject).to be_empty }
        end

        context "when carving_and_marking_receipt_skipped_at has been set" do
          before do
            submission.update_attribute(
              :carving_and_marking_receipt_skipped_at, 1.day.ago)
          end

          it { expect(subject).to be_empty }
        end
      end
    end
  end
end
