require "rails_helper"

describe SequenceNumber::PartThree do
  context ".reg_no!" do
    subject { described_class.reg_no! }

    it { expect(subject).to match(/SSR2[0-9]{5}/) }
  end
end
