require "rails_helper"

describe DownloadableReport do
  describe "#build" do
    let(:user) { create(:user) }
    let(:report) { Report.build(:cefas) }
    subject { described_class.build(user, report) }

    it "generates the file" do
      expect(subject.file.url).to match(%r{.*original\/cefas.xls.*})
    end

    it "assigns the user" do
      expect(subject.user).to eq(user)
    end
  end
end
