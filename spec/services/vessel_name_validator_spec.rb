require "rails_helper"

describe VesselNameValidator do
  describe "#valid?" do
    context ":part_1" do
      subject { described_class.valid?(:part_1, "BOBS BOAT", "foo", nil) }

      it { expect(subject).to be_truthy }

      context "with a registered_vessel of the same name also in part_1" do
        before do
          create(:registered_vessel, part: :part_1, name: "BOBS BOAT")
        end

        it { expect(subject).to be_falsey }
      end

      context "with a name_approval of the same name also in part_1" do
        before do
          create(:name_approval, part: :part_1, name: "BOBS BOAT")
        end

        it { expect(subject).to be_falsey }
      end

      context "with an expired name_approval of the same name also in part_1" do
        before do
          create(:name_approval, part: :part_1,
                                 name: "BOBS BOAT",
                                 approved_until: 1.week.ago)
        end

        it { expect(subject).to be_truthy }
      end

      context "with a pleasure vessel of the same name but in part_4" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 name: "BOBS BOAT",
                 registration_type: :pleasire)
        end

        it { expect(subject).to be_falsey }
      end
    end

    context ":part_2" do
      subject { described_class.valid?(:part_2, "BOBS BOAT", "AB", :simple) }

      it { expect(subject).to be_truthy }

      context "with a fishing vessel of the same name/port also in part_2" do
        before do
          create(:registered_vessel,
                 part: :part_2,
                 port_code: "AB",
                 name: "BOBS BOAT")
        end

        it { expect(subject).to be_falsey }
      end

      context "with a fishing vessel of the same name/port but in part_4" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 port_code: "AB",
                 name: "BOBS BOAT",
                 registration_type: :fishing)
        end

        it { expect(subject).to be_falsey }
      end

      context "with a fishing vessel of the same name but different port" do
        before do
          create(:registered_vessel,
                 part: :part_2,
                 port_code: "DIFFERENT",
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_truthy }
      end

      context "with a pleasure vessel of the same name/port but in part_4" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 port_code: "AB",
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_truthy }
      end
    end

    context ":part_4 fishing vessel" do
      subject { described_class.valid?(:part_4, "BOBS BOAT", "AB", :fishing) }

      it { expect(subject).to be_truthy }

      context "with a fishing vessel of the same name/port" do
        before do
          create(:registered_vessel,
                 part: :part_2,
                 port_code: "AB",
                 name: "BOBS BOAT")
        end

        it { expect(subject).to be_falsey }
      end

      context "with a pleasure vessel of the same name/port/part" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 port_code: "AB",
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_truthy }
      end

      context "with a pleasure vessel of the same name/port but in :part_1" do
        before do
          create(:registered_vessel,
                 part: :part_1,
                 port_code: "AB",
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_truthy }
      end
    end

    context ":part_4 pleasure vessel" do
      subject { described_class.valid?(:part_4, "BOBS BOAT", "AB", :pleasure) }

      it { expect(subject).to be_truthy }

      context "with a part_2 fishing vessel of the same name" do
        before do
          create(:registered_vessel,
                 part: :part_2,
                 name: "BOBS BOAT")
        end

        it { expect(subject).to be_truthy }
      end

      context "with a part_4 fishing vessel of the same name" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 name: "BOBS BOAT",
                 registration_type: :fishing)
        end

        it { expect(subject).to be_truthy }
      end

      context "with a pleasure vessel of the same name/part" do
        before do
          create(:registered_vessel,
                 part: :part_4,
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_falsey }
      end

      context "with a pleasure vessel of the same name but in :part_1" do
        before do
          create(:registered_vessel,
                 part: :part_1,
                 name: "BOBS BOAT",
                 registration_type: :pleasure)
        end

        it { expect(subject).to be_falsey }
      end
    end
  end
end
