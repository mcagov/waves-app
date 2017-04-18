class Pdfs::Extended::CoverLetter < Pdfs::CoverLetter
  def cover_letter_writer(registration)
    Pdfs::Extended::CoverLetterWriter.new(registration, @pdf)
  end
end
