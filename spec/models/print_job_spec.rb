require "rails_helper"

describe PrintJob do
  describe "state machine" do
    let(:print_job) { create(:print_job) }
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }

    it "is unprinted" do
      expect(print_job).to be_unprinted
    end

    context "#printing!" do
      before { print_job.printing!(user_1) }

      it "is printing" do
        expect(print_job).to be_printing
        expect(print_job.printing_at).to be_present
        expect(print_job.printing_by).to eq(user_1)
      end

      context "#printed!" do
        before { print_job.printed!(user_2) }

        it "is printed" do
          expect(print_job).to be_printed
          expect(print_job.printed_at).to be_present
          expect(print_job.printed_by).to eq(user_2)
        end
      end
    end
  end
end
