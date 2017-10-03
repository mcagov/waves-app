class Pdfs::Part2::RenewalReminderLetter < Pdfs::RenewalReminderLetter
  def renewal_reminder_letter_writer(registration)
    Pdfs::Part2::RenewalReminderLetterWriter.new(registration, @pdf).write
  end
end
