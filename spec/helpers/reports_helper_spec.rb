require "rails_helper"
include ReportsHelper

describe ReportsHelper, type: :helper do
  describe "#report_field" do
    subject { helper.report_field(data_element) }

    context "when the data_element is a string" do
      let(:data_element) { "the string" }

      it { expect(subject).to eq("the string") }
    end

    context "when the data_element is a RenderAsRegistrationStatus" do
      let(:data_element) do
        Report::RenderAsRegistrationStatus.new(:registered)
      end

      before do
        expect(helper).to receive(:render).with(
          partial: "/shared/registration_status",
          locals: { registration_status: :registered }
        )
      end

      it { subject }
    end
  end
end
