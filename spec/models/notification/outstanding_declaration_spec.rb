require "rails_helper"

describe Notification::OutstandingDeclaration, type: :model do
  context "in general" do
    let!(:declaration) { create(:declaration) }
    subject { described_class.new(notifiable: declaration) }

    it "has the expected email_template" do
      expect(subject.email_template).to eq(:outstanding_declaration)
    end

    it "has additional_params" do
      expect(subject.additional_params).to eq(
        [declaration.id,
         declaration.submission.vessel.to_s,
         declaration.submission.correspondent.to_s,
        ])
    end
  end
end
