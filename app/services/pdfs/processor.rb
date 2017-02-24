class Pdfs::Processor
  class << self
    def run(template, printable_items, mode = :printable)
      Pdfs::Processor.new(template, printable_items, mode).perform
    end
  end

  def initialize(template, printable_items, mode = :printable)
    @template = template
    @printable_items = printable_items
    @part = Array(@printable_items).first.part.to_sym
    @mode = mode
  end

  def perform
    case @template.to_sym
    when :registration_certificate
      registration_certificate

    when :cover_letter
      cover_letter

    when :current_transcript
      current_transcript

    when :historic_transcript
      historic_transcript
    end
  end

  private

  def registration_certificate
    case @part
    when :part_3
      Pdfs::Part3::Certificate.new(@printable_items, @mode)
    when :part_2
      Pdfs::Part2::Certificate.new(@printable_items, @mode)
    end
  end

  def cover_letter
    Pdfs::CoverLetter.new(@printable_items)
  end

  def current_transcript
    Pdfs::Transcript.new(@printable_items, @mode)
  end

  def historic_transcript
    Pdfs::HistoricTranscript.new(@printable_items, @mode)
  end
end
