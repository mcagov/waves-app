class Pdfs::Part4::RenewalReminderLetter < Pdfs::RenewalReminderLetter
  def renewal_reminder_letter_writer(registration)
    Pdfs::Part4::RenewalReminderLetterWriter.new(registration, @pdf).write
  end
end
