require "rails_helper"

describe Pdfs::Processor do
  let(:template) { :a_template }
  let(:part) { :part_3 }

  let(:printable_items) do
    [create(:print_job, template: template, part: part)]
  end

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

    context "with a registration_certificate" do
      let(:template) { :registration_certificate }

      context "part_1" do
        let(:part) { :part_1 }

        before do
          expect(Pdfs::Part1::Certificate)
            .to receive(:new).with(printable_items, :printable)
        end

        it { subject }
      end

      context "part_2" do
        let(:part) { :part_2 }

        before do
          expect(Pdfs::Part2::Certificate)
            .to receive(:new).with(printable_items, :printable)
        end

        it { subject }
      end

      context "part_3" do
        let(:part) { :part_3 }

        before do
          expect(Pdfs::Part3::Certificate)
            .to receive(:new).with(printable_items, :printable)
        end

        it { subject }
      end

      context "part_4" do
        let(:part) { :part_4 }

        before do
          expect(Pdfs::Part4::Certificate)
            .to receive(:new).with(printable_items, :printable)
        end

        it { subject }
      end
    end

    context "with a provisional_certificate" do
      let(:template) { :provisional_certificate }

      before do
        expect(Pdfs::ProvisionalCertificate)
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

    context "with a carving_and_marking note" do
      let(:template) { :carving_and_marking }

      before do
        expect(Pdfs::CarvingAndMarking)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end

    context "with a csr_form" do
      let(:template) { :csr_form }

      before do
        expect(Pdfs::CsrForm)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end

    context "with a termination_notice" do
      let(:template) { :termination_notice }

      before do
        expect(Pdfs::TerminationNotice)
          .to receive(:new).with(printable_items, :printable)
      end

      it { subject }
    end
  end
end
