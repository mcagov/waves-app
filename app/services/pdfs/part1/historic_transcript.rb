class Pdfs::Part1::HistoricTranscript < Pdfs::HistoricTranscript
  def transcript_writer(registration)
    Pdfs::Part1::TranscriptWriter.new(registration, @pdf, :historic)
  end
end
