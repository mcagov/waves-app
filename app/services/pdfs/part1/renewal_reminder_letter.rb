class Pdfs::Part1::RenewalReminderLetter < Pdfs::RenewalReminderLetter
  def renewal_reminder_letter_writer(registration)
    Pdfs::Part1::RenewalReminderLetterWriter.new(registration, @pdf).write
  end
end
