class Pdfs::Part3::HistoricTranscript < Pdfs::HistoricTranscript
  def transcript_writer(registration)
    Pdfs::Part3::TranscriptWriter.new(registration, @pdf, :historic)
  end
end
