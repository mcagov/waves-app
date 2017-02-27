class Pdfs::Part3::Certificate < Pdfs::Certificate
  def paper_size
    "A6"
  end

  def certificate_writer(registration)
    Pdfs::Part3::CertificateWriter.new(registration, @pdf, @mode)
  end
end
