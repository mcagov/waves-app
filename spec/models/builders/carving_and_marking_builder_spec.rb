require "rails_helper"

describe Builders::CarvingAndMarkingBuilder do
  context ".build" do
    before { described_class.build(carving_and_marking, [recipient]) }

    context "with an emailable C&M note" do
      let(:carving_and_marking) { build(:emailable_carving_and_marking) }
      let(:recipient) { create(:customer) }

      it "builds a notification" do
        notification = Notification::CarvingAndMarkingNote.last
        expect(notification.notifiable).to eq(carving_and_marking)
        expect(notification.attachments).to eq(["carving_and_marking"])
      end
    end

    context "with a printable C&M note with the expected template" do
      let(:carving_and_marking) { build(:printable_carving_and_marking) }
      let(:recipient) { nil }

      it "builds a print_job" do
        print_job = PrintJob.last
        expect(print_job.printable).to eq(carving_and_marking)
        expect(print_job.template.to_sym).to eq(:carving_and_marking)
        expect(print_job.submission).to eq(carving_and_marking.submission)
      end
    end
  end
end
