require "rails_helper"
include MessageHelper

describe "MessageHelper", type: :helper do
  describe "#default_email_text", type: :helper do
    it "shows the cancellation text" do
      expect(helper.default_email_text(:cancel))
        .to match(/CANCELLATION REASON/)
    end

    it "shows the referral text" do
      expect(helper.default_email_text(:refer))
        .to match(/REFERRAL REASON/)
    end

    it "shows the cancellation text" do
      expect(helper.default_email_text(:cancel))
        .to match(/CANCELLATION REASON/)
    end
  end
end
