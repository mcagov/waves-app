class Pdfs::Part4::Transcript < Pdfs::Transcript
  def transcript_writer(registration)
    Pdfs::Part4::TranscriptWriter.new(registration, @pdf)
  end
end
