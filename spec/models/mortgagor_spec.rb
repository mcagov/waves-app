require "rails_helper"

describe Mortgagor do
  context "when the declaration_owner_id is assigned" do
    let(:declaration_owner) { create(:declaration_owner) }

    let(:mortgagor) do
      Mortgagor.create!(declaration_owner_id: declaration_owner.id)
    end

    it "assigns the declaration_owner fields" do
      expect(mortgagor.name).to eq(declaration_owner.name)
      expect(mortgagor.address_1).to eq(declaration_owner.address_1)
      expect(mortgagor.address_2).to eq(declaration_owner.address_2)
      expect(mortgagor.address_3).to eq(declaration_owner.address_3)
      expect(mortgagor.town).to eq(declaration_owner.town)
      expect(mortgagor.postcode).to eq(declaration_owner.postcode)
      expect(mortgagor.country).to eq(declaration_owner.country)
    end
  end
end
