module MailerHelper
  def contact_us_for_part
    "the SSR team at: ssr.registry@mcga.gov.uk"
  end

  def part_of_register
    if @part == :part_3
      "Part III of the UK Small Ships Register"
    else
      "#{Activity.new(@part)} of the Register"
    end
  end

  def officer_phone_for_part
    "02920 448813"
  end

  def official_number_for_part
    "SSR Number"
  end

  def if_no_certificate
    "If you do not receive a response from us within 20 days (or 5 days if "\
    "you paid for a Premium Service) of today's date, please contact "\
    "#{contact_us_for_part}"\
  end

  def quote_ref_no
    "Please quote the Application Reference Number listed above in all "\
    "correspondence relating to this application."
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
    "Please be aware that your application may take up to 20 working days "\
    "to process, unless a premium service was applied for in which case it "\
    "may take up to 3 working days to process. Please make a note "\
    "of the Application Reference Number detailed below:"
  end
end
