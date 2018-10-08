class Pdfs::PaymentReceipt
  def initialize(payment_receipts, mode = :printable)
    @payment_receipts = Array(payment_receipts)
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @payment_receipts.each do |payment_receipt|
      @pdf = Pdfs::PaymentReceiptWriter.new(payment_receipt, @pdf).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    "payment-receipt.pdf"
  end
end
