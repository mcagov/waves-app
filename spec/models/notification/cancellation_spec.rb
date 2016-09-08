require "rails_helper"

describe Notification::Cancellation, type: :model do
  context "in general" do
    let(:submission) { build(:submission) }
    subject { described_class.new(subject: reason, notifiable: submission) }

    context "reason: owner_request" do
      let(:reason) { :owner_request }

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:cancellation_owner_request)
      end

      it "builds the expected email_params" do
        expect(subject.email_params).to eq(
          [notifiable.owner.email,additional_info])
      end
    end

    context "reason: owner_request" do
      let(:reason) { :no_reponse_from_owner }

      it "has the expected email_template" do
        expect(subject.email_template).to eq(:cancellation_no_response)
      end
    end
  end
end
