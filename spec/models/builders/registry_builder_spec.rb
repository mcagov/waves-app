require "rails_helper"

describe Builders::RegistryBuilder do
  context ".create" do
    let(:submission) { init_basic_submission }
    before { described_class.create(submission) }

    let(:registered_vessel) { Register::Vessel.last }

    it "creates the expected vessel name" do
      expect(registered_vessel.name).to eq("BOB BARGE")
    end

    it "sets the registry part" do
      expect(registered_vessel.part.to_sym).to eq(:part_3)
    end

    it "creates registered owners in the expect order" do
      expect(registered_vessel.owners.length).to eq(2)
      expect(registered_vessel.owners.first.name).to eq("ALICE")
      expect(registered_vessel.owners.last.name).to eq("BOB LTD")
    end

    it "sets the registered owners entity type" do
      expect(registered_vessel.owners.first.entity_type.to_sym)
        .to eq(:individual)
      expect(registered_vessel.owners.last.entity_type.to_sym)
        .to eq(:corporate)
    end

    it "creates the registered agent" do
      expect(registered_vessel.reload.agent.name).to eq("Annabel Agent")
    end

    context "with a task that changes registry details" do
      let!(:change_vessel_submission) do
        create(:assigned_submission,
               task: :re_registration,
               registered_vessel: registered_vessel,
               changeset: {
                 vessel_info: build(:submission_vessel, name: "DON DINGHY"),
                 owners: [
                   { name: "ALICE" }, { name: "DAVE" }, { name: "ELLEN" }],
               })
      end

      before do
        described_class.create(change_vessel_submission)
        registered_vessel.reload
      end

      it "updates the vessel name" do
        expect(registered_vessel.name).to eq("DON DINGHY")
      end

      it "creates registered owners in the expect order" do
        expect(registered_vessel.owners.length).to eq(3)
        expect(registered_vessel.owners[0].name).to eq("ALICE")
        expect(registered_vessel.owners[1].name).to eq("DAVE")
        expect(registered_vessel.owners[2].name).to eq("ELLEN")
      end
    end

    context "with an extended submission type (ie. not part_3)" do
      let(:submission) { init_extended_submission }
      let(:alice) { registered_vessel.owners.first }
      let(:bob) { registered_vessel.owners.last }

      it "sets alice as the managing_owner" do
        expect(alice).to be_managing_owner
        expect(bob).not_to be_managing_owner
      end

      it "bob as the correspondent" do
        expect(alice).not_to be_correspondent
        expect(registered_vessel.owners.last).to be_correspondent
      end

      it "notes that alice has 20 shares" do
        expect(alice.shares_held).to eq(20)
      end

      it "notes that bob is a member of a group holding 10 shares jointly" do
        shareholder_group = registered_vessel.shareholder_groups.first

        expect(shareholder_group.shares_held).to eq(10)
        expect(shareholder_group.shareholder_group_members.map(&:owner))
          .to include(bob)
      end

      it "creates the engines" do
        expect(registered_vessel.reload.engines.map(&:make))
          .to include("Honda")
        expect(registered_vessel.reload.engines.map(&:make))
          .to include("Yamaha")
      end

      it "creates the documents" do
        document = registered_vessel.reload.documents.first
        expect(document.entity_type.to_sym).to eq(:other)
        expect(document.asset.file_file_name).to eq("myfile.pdf")
      end

      it "creates the mortgages" do
        mortgage = registered_vessel.reload.mortgages.first
        expect(mortgage.reference_number).to eq("MGT_1")
        expect(mortgage.mortgagees.first.name).to eq("Mary")
      end

      it "retains the submission's mortgages" do
        expect(submission.reload.mortgages.first.reference_number)
          .to eq("MGT_1")
      end

      it "creates the beneficial_owners" do
        beneficial_owner = registered_vessel.reload.beneficial_owners.first
        expect(beneficial_owner.name).to eq("Barry")
      end

      it "creates the representative" do
        representative = registered_vessel.reload.representative
        expect(representative.name).to eq("Ronnie")
      end
    end
  end
end

def init_basic_submission # rubocop:disable Metrics/MethodLength
  submission =
    create(:submission,
           changeset: {
             vessel_info: build(:submission_vessel, name: "BOB BARGE"),
             agent: build(:submission_agent),
             representative: build(:submission_representative, name: "Ronnie"),
           })

  submission.declarations.create(owner: { name: "ALICE" }, shares_held: 20)
  submission.declarations.create(
    entity_type: :corporate, owner: { name: "BOB LTD" })

  submission.engines.create(make: "Honda")
  submission.engines.create(make: "Yamaha")

  submission.documents.create(
    entity_type: :other,
    assets: [Asset.new(file_file_name: "myfile.pdf")])

  submission.mortgages.create(
    reference_number: "MGT_1",
    mortgagees: [Mortgagee.new(name: "Mary")])

  submission.beneficial_owners.create(
    name: "Barry")

  submission
end

def init_extended_submission
  submission = init_basic_submission
  submission.update_attributes(
    managing_owner_id: submission.declarations.first.id,
    correspondent_id: submission.declarations.last.id)

  submission.declaration_groups.create(
    shares_held: 10,
    default_group_member: submission.declarations.last.id)

  submission
end
