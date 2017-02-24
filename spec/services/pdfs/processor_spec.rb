require "rails_helper"

describe Pdfs::Processor do
  let(:template) { :a_template }
  let(:printable_items) { [create(:print_job, template: template)] }

  context ".run" do
    before do
      processor = double(:processor)

      expect(Pdfs::Processor)
        .to receive(:new)
        .with(template, printable_items, :printable)
        .and_return(processor)

      expect(processor).to receive(:perform)
    end

    it { described_class.run(template, printable_items) }
  end

  context "#perform" do
    subject { described_class.new(template, printable_items).perform }

    context "with a part_3 registration_certificate" do
      let(:template) { :registration_certificate }

      before do
        expect(Pdfs::Part3::Certificate)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end

    context "with a generic cover_letter" do
      let(:template) { :cover_letter }

      before do
        expect(Pdfs::CoverLetter)
          .to receive(:new).with(printable_items)
      end

      it { subject }
    end

    context "with a generic current_transcript" do
      let(:template) { :current_transcript }

      before do
        expect(Pdfs::Transcript)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end

    context "with a generic historic_transcript" do
      let(:template) { :historic_transcript }

      before do
        expect(Pdfs::HistoricTranscript)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end
  end
end
