require "rails_helper"

describe TargetDate do
  let(:start_date) { Date.civil(2016, 3, 24) }
  let(:target_date_standard) { Date.civil(2016, 4, 8) }
  let(:target_date_urgent) { Date.civil(2016, 3, 30) }

  subject { described_class.new(start_date, mode) }

  context "#calculate" do
    context ":standard by default" do
      let(:mode) { :standard }

      it "is 10 working days" do
        expect(subject.calculate).to eq(target_date_standard)
      end
    end

    context ":urgent" do
      let(:mode) { :urgent }

      it "is 3 working days" do
        expect(subject.calculate).to eq(target_date_urgent)
      end
    end
  end
end
