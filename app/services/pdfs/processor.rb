class Pdfs::Processor
  class << self
    def run(template, printable_items)
      case template.to_sym
      when :registration_certificate
        Pdfs::Part3::Certificate.new(printable_items)

      when :cover_letter
        Pdfs::CoverLetter.new(printable_items)

      when :current_transcript
        Pdfs::Transcript.new(printable_items)

      when :historic_transcript
        Pdfs::HistoricTranscript.new(printable_items)
      end
    end
  end
end
