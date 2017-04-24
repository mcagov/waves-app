class Pdfs::Part3::Transcript < Pdfs::Transcript
  def transcript_writer(registration)
    Pdfs::Part3::TranscriptWriter.new(registration, @pdf)
  end
end
