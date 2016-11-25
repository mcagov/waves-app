require "rails_helper"

describe Builders::PrintJobBuilder do
  context ".create" do
    before do
      described_class.create(
        registration, :part_1, [:a_template, :b_template])
    end

    let(:print_jobs) { PrintJob.all }

    context "with valid params" do
      let(:registration) { create(:registration) }

      it "builds two print jobs" do
        expect(print_jobs[0].printable).to eq(registration)
        expect(print_jobs[0].template.to_sym).to eq(:a_template)
        expect(print_jobs.last.template.to_sym).to eq(:b_template)
      end
    end
  end
end
