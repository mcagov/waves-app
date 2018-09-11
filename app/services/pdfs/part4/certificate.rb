class Pdfs::Part4::Certificate < Pdfs::Certificate
  def paper_size
    "A4"
  end

  def certificate_writer(registration)
    Pdfs::Part4::CertificateWriter.new(registration, @pdf, @mode, @duplicate)
  end
end
