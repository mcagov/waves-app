require "rails_helper"
include MessageHelper

describe "MessageHelper", type: :helper do
  describe "#default_email_text", type: :helper do
    let(:submission) { build(:submission) }

    it "shows the referral text" do
      assign(:submission, submission)
      expect(helper.default_email_text(:refer, submission))
        .to match(/In order for us to proceed/)
    end

    it "shows the cancellation text" do
      assign(:submission, submission)
      expect(helper.default_email_text(:cancel, submission))
        .to match(/your application has been cancelled/)
    end
  end
end
