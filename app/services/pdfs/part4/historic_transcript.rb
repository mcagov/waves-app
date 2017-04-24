class Pdfs::Part4::HistoricTranscript < Pdfs::HistoricTranscript
  def transcript_writer(registration)
    Pdfs::Part4::TranscriptWriter.new(registration, @pdf, :historic)
  end
end
