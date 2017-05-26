require "rails_helper"

describe Mortgagor do
  context "when the declaration_owner_id is assigned" do
    let(:declaration) { create(:declaration) }

    let(:mortgagor) { Mortgagor.create!(declaration_owner_id: declaration.id) }

    it "assigns the declaration_owner fields" do
      expect(mortgagor.name).to eq(declaration.owner.name)
      expect(mortgagor.address_1).to eq(declaration.owner.address_1)
      expect(mortgagor.address_2).to eq(declaration.owner.address_2)
      expect(mortgagor.address_3).to eq(declaration.owner.address_3)
      expect(mortgagor.town).to eq(declaration.owner.town)
      expect(mortgagor.postcode).to eq(declaration.owner.postcode)
      expect(mortgagor.country).to eq(declaration.owner.country)
    end
  end
end
