require "rails_helper"

describe Policies::Validations do
  describe ".errors" do
    subject { described_class.new(task).errors }

    context "default state" do
      let(:task) { build(:submission_task) }

      it { expect(subject).to be_empty }
    end

    context "for a service that validates_on_approval" do
      let(:task) do
        build(:submission_task,
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
    end

    context "for a service that requires declarations" do
      let(:task) do
        create(:submission_task,
               submission: create(:submission,
                                  declarations: [create(:declaration)]),
               service: create(:service, :declarations_required))
      end

      it { expect(subject).to include(:declarations_required) }
    end

    context "carving_and_marking_required" do
      let(:task) do
        create(:submission_task,
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
      end
    end
  end
end
