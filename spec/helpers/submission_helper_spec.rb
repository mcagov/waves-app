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
end
