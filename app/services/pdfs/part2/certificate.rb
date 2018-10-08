class Pdfs::Part2::Certificate < Pdfs::Certificate
  def paper_size
    "A4"
  end

  def certificate_writer(registration)
    Pdfs::Part2::CertificateWriter.new(registration, @pdf, @mode, @duplicate)
  end
end
