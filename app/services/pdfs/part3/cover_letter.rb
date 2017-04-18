class Pdfs::Part3::CoverLetter < Pdfs::CoverLetter
  def cover_letter_writer(registration)
    Pdfs::Part3::CoverLetterWriter.new(registration, @pdf)
  end
end
