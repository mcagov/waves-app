require "rails_helper"

describe Registration do
  context "#delivery_name_and_address" do
    let(:registration) { create(:registered_vessel).current_registration }
    subject { registration.reload.delivery_name_and_address }

    context "with a submission" do
      let!(:submission) { create(:submission, registration: registration) }

      it "uses the submission's delivery address" do
        expect(subject[0]).to eq(submission.delivery_address.name)
      end
    end

    context "without a submission" do
      it "is an empty array" do
        expect(subject).to eq([])
      end
    end
  end

  context "#submission_ref_no" do
    let(:registration) { create(:registered_vessel).current_registration }
    subject { registration.reload.submission_ref_no }

    context "with a submission" do
      let!(:submission) { create(:submission, registration: registration) }

      it "retrieves the submission's ref_no" do
        expect(subject).to eq(submission.ref_no)
      end
    end

    context "without a submission" do
      it "is nil" do
        expect(subject).to be_nil
      end
    end
  end

  context "#part" do
    let(:registration) { build(:registration, registry_info: registry_info) }

    context "when the registry_info is not defined (edge case)" do
      let(:registry_info) { nil }

      it "defaults to part_3" do
        expect(registration.part.to_sym).to eq(:part_3)
      end
    end

    context "when the registry_info#vessel_info is part_1" do
      let(:registry_info) { { vessel_info: { part: "part_1" } } }

      it { expect(registration.part).to eq(:part_1) }
    end
  end

  context "#certificate_template" do
    subject { registration.certificate_template }

    context "for a registration" do
      let(:registration) { build(:registration) }

      it { expect(subject).to eq(:registration_certificate) }
    end

    context "for a provisional registration" do
      let(:registration) { build(:provisional_registration) }

      it { expect(subject).to eq(:provisional_certificate) }
    end
  end

  context "#mortgages" do
    let(:active_mortgage) { create(:mortgage) }
    let(:discharged_mortgage) { create(:mortgage, :discharged) }

    let(:registration) do
      create(
        :registration,
        registry_info: {
          mortgages: [active_mortgage, discharged_mortgage],
        })
    end

    subject { registration.mortgages }

    it "only returns the active mortgage" do
      expect(subject).to eq([active_mortgage])
    end
  end
end
