require "rails_helper"

describe Notification::OutstandingDeclaration, type: :model do
  context "in general" do
    let(:declaration) { create(:declaration) }
    subject { described_class.new(notifiable: declaration) }

    it "has the expected email_template" do
      expect(subject.email_template).to eq(:outstanding_declaration)
    end

    it "builds the expected email_params" do
      expect(subject.email_params).to eq(
        [
          declaration.owner.email,
          declaration.owner.name,
          declaration.id,
        ]
      )
    end
  end
end
