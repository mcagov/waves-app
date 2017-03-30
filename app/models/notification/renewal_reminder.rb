class Notification::RenewalReminder < Notification
  def deliverable?
    false
  end
end
