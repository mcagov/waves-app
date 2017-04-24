class Pdfs::Part1::Transcript < Pdfs::Transcript
  def transcript_writer(registration)
    Pdfs::Part1::TranscriptWriter.new(registration, @pdf)
  end
end
