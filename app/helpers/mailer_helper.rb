module MailerHelper
  def contact_us_for_part
    "the SSR team at: ssr.registry@mcga.gov.uk"
  end

  def part_of_register
    "Part III of the UK Small Ships Register"
  end

  def officer_phone_for_part
    "02920 448813"
  end

  def official_number_for_part
    "SSR Number"
  end

  def if_no_certificate
    "If you do not receive a Certificate of British Registry within 20 days "\
    "of today's date, please contact #{contact_us_for_part}"
  end

  def quote_ref_no
    "Please quote the Application Reference No. "\
    "listed above in all correspondence."
  end

  def will_be_sent
    "will be sent by first class mail, to the address requested "\
    "in the application"
  end

  def pending_declaration_msg
    "Please note that your application will not be processed until all "\
    "declarations have been received."
  end

  def application_processing_time
    "Your application may take up to 20 days to process. Please make a "\
    "note of the Application Reference No detailed below:"
  end
end
