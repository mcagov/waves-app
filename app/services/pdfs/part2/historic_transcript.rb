class Pdfs::Part2::HistoricTranscript < Pdfs::HistoricTranscript
  def transcript_writer(registration)
    Pdfs::Part2::TranscriptWriter.new(registration, @pdf, :historic)
  end
end
