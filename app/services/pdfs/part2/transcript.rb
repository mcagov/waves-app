class Pdfs::Part2::Transcript < Pdfs::Transcript
  def transcript_writer(registration)
    Pdfs::Part2::TranscriptWriter.new(registration, @pdf)
  end
end
