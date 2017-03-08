require "rails_helper"

describe Builders::OfficialNoBuilder do
  context ".build" do
    let(:submission) { create(:submission, part: :part_2) }

    before { described_class.build(submission) }

    it { expect(submission.vessel_reg_no).to be_present }
  end
end
