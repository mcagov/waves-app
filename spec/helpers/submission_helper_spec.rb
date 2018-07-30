require "rails_helper"
include SubmissionHelper

describe "SubmissionHelper", type: :helper do
  describe "#payment_status_icon" do
    it "is :paid" do
      expect(helper.payment_status_icon(:paid))
        .to match(/i fa fa-check green/)
    end

    it "is :part_paid" do
      expect(helper.payment_status_icon(:part_paid))
        .to match(/i fa fa-check-circle-o/)
    end

    it "is :unpaid" do
      expect(helper.payment_status_icon(:unpaid))
        .to match(/i fa fa-times red/)
    end

    it "it :not_applicable" do
      expect(helper.payment_status_icon(:not_applicable))
        .to eq("n/a")
    end
  end

  describe "#similar_attribute_icon", type: :helper do
    it "shows the icon" do
      expect(helper.similar_attribute_icon(:foo, "a", "a"))
        .to match(/i fa fa-star-o/)
    end

    it "does not show the icon with different values" do
      expect(helper.similar_attribute_icon(:foo, "a", 1))
        .to be_blank
    end

    it "does not show the icon with empty strings" do
      expect(helper.similar_attribute_icon(:foo, "", ""))
        .to be_blank
    end
  end

  describe "#claimed_by" do
    subject { helper.claimed_by(submission) }

    context "with a claimant" do
      let(:submission) { create(:assigned_submission) }

      it { expect(subject).to eq("claimed by #{submission.claimant}") }
    end

    context "without a claimant" do
      let(:submission) { create(:submission) }

      it { expect(subject).to eq("unclaimed") }
    end
  end

  describe "can_delete_mortgage?" do
    let(:mortgage) { build(:mortgage, priority_code: "A") }
    subject { helper.can_delete_mortgage?(mortgage) }

    context "when the mortgage has already been recorded against the vessel" do
      it do
        assign(:submission, create(:assigned_re_registration_submission))
        expect(subject).to be_falsey
      end
    end

    context "when the submission does not have a registered_vessel" do
      it do
        assign(:submission, Submission.new)
        expect(subject).to be_truthy
      end
    end

    context "when the page is readonly" do
      it do
        assign(:readonly, true)
        expect(subject).to be_falsey
      end
    end
  end
end
