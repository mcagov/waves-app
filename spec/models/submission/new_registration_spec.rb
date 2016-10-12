require "rails_helper"

describe Submission::NewRegistration, type: :model do
  context "in general" do
    let!(:new_registration) { create_incomplete_submission! }

    it "has a ref_no with the expected prefix" do
      expect(new_registration.ref_no).to match(/3N-.*/)
    end
  end

  context "#process_application" do
    let!(:new_registration) { create_assigned_submission! }

    before do
      expect(Builders::NewRegistrationBuilder)
        .to receive(:create)
        .with(new_registration, "12/12/2020 11:59 AM".to_datetime)

      new_registration.process_application("12/12/2020 11:59 AM")
    end

    it "has not printed the registration_certificate" do
      expect(new_registration.printed?(:registration_certificate))
        .to be_falsey
    end

    it "has not printed the cover_letter" do
      expect(new_registration.printed?(:cover_letter))
        .to be_falsey
    end
  end

  context "#update_print_job" do
    let!(:new_registration) { create_printing_submission! }

    context "printing the registration_certificate" do
      before do
        new_registration.update_print_job!(:registration_certificate)
      end

      it "has printed the registration_certificate" do
        expect(new_registration.printed?(:registration_certificate))
          .to be_truthy
      end

      it "has the state printing" do
        expect(new_registration).to be_printing
      end

      context "printing the cover_letter" do
        before do
          new_registration.update_print_job!(:cover_letter)
        end

        it "has the state completed" do
          expect(new_registration).to be_completed
        end
      end
    end
  end
end
