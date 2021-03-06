require "rails_helper"

describe Policies::Validations do
  describe "#errors" do
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

      context "Radio Call Sign" do
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

      context "Year of Build" do
        let(:submission) do
          build(
            :submission,
            changeset: { vessel_info: { year_of_build: year_of_build } })
        end

        context "is blank" do
          let(:year_of_build) { "" }

          it { expect(subject).not_to include(:year_of_build_invalid) }
        end

        context "is invalid" do
          let(:year_of_build) { "999" }

          it { expect(subject).to include(:year_of_build_invalid) }
        end

        context "is valid" do
          let(:year_of_build) { "1700" }

          it { expect(subject).not_to include(:year_of_build_invalid) }
        end

        context "is valid" do
          let(:year_of_build) { "2020" }

          it { expect(subject).not_to include(:radio_call_sign_invalid) }
        end
      end

      context "part_3_length" do
        let(:submission) do
          build(
            :submission,
            part: part,
            changeset: { vessel_info: { length_in_meters: length_in_meters } })
        end

        context "part_3" do
          let(:part) { :part_3 }

          context "is blank" do
            let(:length_in_meters) { "" }

            it { expect(subject).to include(:part_3_length_invalid) }
          end

          context "is not number" do
            let(:length_in_meters) { "ABC" }

            it { expect(subject).to include(:part_3_length_invalid) }
          end

          context "is too long" do
            let(:length_in_meters) { "24.1" }

            it { expect(subject).to include(:part_3_length_invalid) }
          end

          context "is valid" do
            let(:length_in_meters) { "24.0" }

            it { expect(subject).not_to include(:part_3_length_invalid) }
          end
        end

        context "part_1 (all non-part_3)" do
          let(:part) { :part_1 }

          context "is blank" do
            let(:length_in_meters) { "" }

            it { expect(subject).not_to include(:part_3_length_invalid) }
          end
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

  describe "#warnings" do
    subject { described_class.new(task).warnings }

    context "default state" do
      let(:task) { build(:task) }

      it { expect(subject).to be_empty }
    end

    context "for a service with prompt_if_registered_mortgage" do
      let(:task) do
        create(
          :task,
          service: create(:service, :prompt_if_registered_mortgage),
          submission: build(:submission, mortgages: mortgages))
      end

      context "with a registered mortgage" do
        let(:mortgages) { [create(:mortgage, :registered)] }

        it { expect(subject).to include(:registered_mortgage_exists) }
      end

      context "with a discharged mortgage" do
        let(:mortgages) { [create(:mortgage, :discharged)] }

        it { expect(subject).to be_empty }
      end

      context "with a mortgage of intent" do
        let(:mortgages) { [create(:mortgage, :intent)] }

        it { expect(subject).to be_empty }
      end

      context "with no mortgage" do
        let(:mortgages) { [] }

        it { expect(subject).to be_empty }
      end
    end
  end
end
