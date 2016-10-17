require "rails_helper"

describe Builders::ProcessingDatesBuilder do
  context ".create" do
    it "replaces the tests below"

    it "shouldnt need the payment amount input"

    # context "paid! (with a declared submission)" do
    #   context "with standard service" do
    #     let!(:submission) { create_assigned_submission! }

    #     it "sets the received_at date to today" do
    #       expect(submission.received_at.to_date)
    #         .to eq(Date.today)
    #     end

    #     it "sets the target_date to 20 days away" do
    #       expect(submission.target_date.to_date)
    #         .to eq(Date.today.advance(days: 20))
    #     end

    #     it "is not urgent" do
    #       expect(submission.is_urgent).to be_falsey
    #     end
    #   end

    #   context "with urgent service" do
    #     let!(:submission) { create_unassigned_urgent_submission! }

    #     it "sets the target_date to 5 days away (best guess)" do
    #       expect(submission.target_date.to_date)
    #         .to eq(Date.today.advance(days: 5))
    #     end

    #     it "is urgent" do
    #       expect(submission.is_urgent).to be_truthy
    #     end
    #   end
    # end

    # context "paid! (with an undeclared submission)" do
    #   let!(:submission) { create_incomplete_submission! }

    #   it "does not set the received_at date" do
    #     expect(submission.received_at).to be_blank
    #   end

    #   it "does not set the target_date" do
    #     expect(submission.target_date).to be_blank
    #   end
    # end
  end
end
