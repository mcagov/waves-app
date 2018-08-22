require "rails_helper"

describe Customer do
  let!(:customer) { build(:customer) }

  context "in general" do
    it { expect(customer.to_s).to eq("Bob") }

    it do
      expect(customer.details)
        .to eq(name: "Bob", inline_address: customer.inline_address)
    end
  end

  context "#individual?" do
    subject { described_class.new(entity_type: entity_type).individual? }

    context "by default" do
      let(:entity_type) { nil }

      it { expect(subject).to be_truthy }
    end

    context "for a corporate owner" do
      let(:entity_type) { :corporate }

      it { expect(subject).to be_falsey }
    end
  end

  context "#email_description" do
    let(:customer) { build(:customer, name: "BOB", email: email) }

    subject { customer.email_description }

    context "with no email address" do
      let(:email) { nil }

      it { expect(subject).to eq("Not set") }
    end

    context "with name and email address" do
      let(:email) { "bob@example.com" }

      it { expect(subject).to eq("BOB <bob@example.com>") }
    end
  end
end
