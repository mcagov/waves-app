require "rails_helper"

describe WavesDates do
  describe ".next_working_day" do
    subject { WavesDates.next_working_day(the_date) }

    context "on a saturday over easter" do
      let(:the_date) { Date.civil(2016, 3, 26) }

      it { expect(subject).to eq(Date.civil(2016, 3, 29)) }
    end

    context "on a normal working day" do
      let(:the_date) { Date.civil(2016, 3, 29) }

      it { expect(subject).to eq(Date.civil(2016, 3, 29)) }
    end
  end
end
