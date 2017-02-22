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

      context "when the registered vessel has name_approved_until set" do
        before do
          registered_vessel
            .update_attribute(:name_approved_until, 1.week.from_now)
          described_class.create(change_vessel_submission)
        end

        it "unsets name_approved_until" do
          expect(registered_vessel.name_approved_until).to be_blank
        end
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
          .to eq(%w(Honda Yamaha))
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
           })

  submission.declarations.create(owner: { name: "ALICE" }, shares_held: 20)
  submission.declarations.create(
    entity_type: :corporate, owner: { name: "BOB LTD" })

  submission.engines.create(make: "Honda")
  submission.engines.create(make: "Yamaha")

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
