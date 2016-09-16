require "rails_helper"
include SubmissionHelper

describe "SubmissionHelper", type: :helper do
  describe "#css_tick" do
    it "shows the green tick" do
      expect(helper.css_tick(true)).to match(/i fa fa-check green/)
    end

    it "shows the red cross" do
      expect(helper.css_tick(false)).to match(/i fa fa-times red/)
    end
  end

  describe "#similar_attribute_icon", type: :helper do
    it "shows the icon" do
      expect(helper.similar_attribute_icon("a", "a"))
        .to match(/i fa fa-star-o/)
    end

    it "does not show the icon with different values" do
      expect(helper.similar_attribute_icon("a", 1))
        .to be_blank
    end

    it "does not show the icon with empty strings" do
      expect(helper.similar_attribute_icon("", ""))
        .to be_blank
    end
  end
end
