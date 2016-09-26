require "rails_helper"
include EditableSubmissionHelper

describe "EditableSubmissionHelper", type: :helper do
  describe "#editable_link_to", type: :helper do
    it "shows the edit link" do
      expect(helper.editable_link_to(true, "My page", "/my-page"))
        .to eq(link_to("My page", "/my-page"))
    end

    it "does not show the edit link" do
      expect(helper.editable_link_to(false, "My page", "/my-page"))
        .to eq("My page")
    end
  end
end
