class Pdfs::Part3::RenewalReminderLetter < Pdfs::RenewalReminderLetter
  def renewal_reminder_letter_writer(registration)
    Pdfs::Part3::RenewalReminderLetterWriter.new(registration, @pdf).write
  end
end
