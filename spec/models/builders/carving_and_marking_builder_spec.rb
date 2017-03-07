require "rails_helper"

describe Builders::CarvingAndMarkingBuilder do
  context ".build" do
    before do
      described_class.build(carving_and_marking)
    end

    context "with a printable C&M note" do
      let(:carving_and_marking) { create(:emailable_carving_and_marking) }

      it "builds a notification with the expected attachment" do
        notification = Notification::CarvingAndMarkingNote.last
        expect(notification.notifiable).to eq(carving_and_marking)
        expect(notification.attachments.to_sym).to eq(:carving_and_marking)
      end
    end

    context "with an emailable C&M note with the expected template" do
      let(:carving_and_marking) { create(:printable_carving_and_marking) }

      it "builds a print_job" do
        print_job = PrintJob.last
        expect(print_job.printable).to eq(carving_and_marking)
        expect(print_job.template.to_sym).to eq(:carving_and_marking)
      end
    end
  end
end
