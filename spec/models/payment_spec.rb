require "rails_helper"

RSpec.describe Payment, type: :model do
  context "#create" do
    let(:payment) { create(:payment) }

    it "sets the submission to unassigned" do
      expect(payment.submission.reload).to be_unassigned
    end
  end
end
