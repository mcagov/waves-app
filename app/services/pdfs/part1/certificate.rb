class Pdfs::Part1::Certificate < Pdfs::Certificate
  def paper_size
    "A4"
  end

  def certificate_writer(registration)
    Pdfs::Part1::CertificateWriter.new(registration, @pdf, @mode)
  end
end
