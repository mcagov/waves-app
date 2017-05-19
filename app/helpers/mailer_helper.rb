module MailerHelper
  def department
    @department ||=
      Department.new(
        @submission.part,
        Policies::Definitions.registration_type(@submission))
  end

  def contact_us_for_part
    department.contact_us
  end

  def part_of_register
    department.part_of_register
  end

  def officer_phone_for_part
    department.phone
  end

  def official_number_for_part
    department.official_number_for_part
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

  def application_processing_time_no_premium
    "Please be aware that your application may take up to 20 working days "\
    "to process, Please make a note "\
    "of the Application Reference Number detailed below:"
  end
end
