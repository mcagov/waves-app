require "rails_helper"

describe RegistrationDate do
  context ".for" do
    before { Timecop.freeze(Time.local(2012, 11, 24, 10, 10, 0)) }
    after { Timecop.return }

    subject { described_class.for(task) }

    context "when the task will generate_new_5_year_registration" do
      let!(:task) do
        create(:claimed_task,
               submission: create(:submission, part: :part_3),
               service: create(:service, :generate_new_5_year_registration))
      end

      it "sets starts_at to today" do
        expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
      end

      it "sets ends_at to 5 years ahead" do
        expect(subject.ends_at.to_date).to eq(Date.new(2017, 11, 24))
      end
    end

    context "when the task will restore_closure" do
      let!(:task) do
        create(:claimed_task,
               submission: create(:submission, :closed_part_3_vessel),
               service: create(:service, :restore_closure))
      end

      let!(:previous_registration) do
        task.submission.registered_vessel.current_registration
      end

      it do
        expect(subject.starts_at).to eq(previous_registration.registered_at)
      end

      it do
        expect(subject.ends_at).to eq(previous_registration.registered_until)
      end
    end

    context "when the task will generate_provisional_registration" do
      let!(:task) do
        create(:claimed_task,
               submission: create(:submission, part: :part_3),
               service: create(:service, :generate_provisional_registration))
      end

      it "sets starts_at to today" do
        expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
      end

      it "sets ends_at to 90 days ahead" do
        expect(subject.ends_at.to_date).to eq(Date.new(2013, 2, 22))
      end
    end

    context "when a new certificate is not issued" do
      let!(:task) do
        create(:claimed_task,
               submission: create(:submission, part: :part_3),
               service: create(:service, :generate_provisional_registration))
      end
    end

    context "for a registered_vessel" do
      let!(:registered_vessel) { create(:registered_vessel) }

      let!(:task) do
        create(:claimed_task,
               submission: create(:submission,
                                  vessel_reg_no: registered_vessel.reg_no))
      end

      it "sets the ends_at to the vessel's registered_until" do
        expect(subject.ends_at)
          .to eq(task.submission.registered_vessel.registered_until)
      end

      context "when current registration expires within next 3 months" do
        before do
          allow(registered_vessel)
            .to receive(:registered_until)
            .and_return(Date.new(2012, 12, 24))
        end

        it "sets the starts_at to the vessel's registered_until" do
          expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
        end
      end

      context "when current registration expires more than 3 months away" do
        before do
          allow(registered_vessel)
            .to receive(:registered_until)
            .and_return(Date.new(2016, 12, 24))
        end

        it "sets the starts_at to today" do
          expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
        end
      end
    end
  end
end
