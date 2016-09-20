require "rails_helper"

describe Declaration::Owner do
  context "#new" do
    subject { described_class.new(input_params) }

    context "in general" do
      let(:input_params) do
        { name: "A real name", non_existent: "rubbish" }
      end

      it "has a name" do
        expect(subject.name).to eq("A real name")
      end

      it "does not have non_existent" do
        expect { subject.non_existent }.to raise_error(NoMethodError)
      end
    end

    context "#inline_address" do
      let(:input_params) do
        {
          address_1: "10 Downing St",
          address_2: "Whitehall",
          town: "London",
        }
      end

      it "rendes the expected address fields" do
        expect(subject.inline_address).to eq("10 Downing St, Whitehall, London")
      end
    end
  end

  context "#assign_attributes" do
    let!(:declaration) { create(:declaration) }
    let(:owner) { declaration.owner }

    before do
      owner.assign_attributes(name: "John Doe")
    end

    it "updates the owner name" do
      expect(owner.name).to eq("John Doe")
    end
  end
end
