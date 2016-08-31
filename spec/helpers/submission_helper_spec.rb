require "rails_helper"
include SubmissionHelper

describe "SubmissionHelper", type: :helper do

  describe "#css_tick" do

    it "shows the green tick" do
      expect(helper.css_tick(true)).to match(/i fa fa-times red/)
    end

    it "shows the red cross" do
      expect(helper.css_tick(false)).to match(/i fa fa-check green/)
    end
  end
end
