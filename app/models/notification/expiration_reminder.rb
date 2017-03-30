class Notification::ExpirationReminder < Notification
  def deliverable?
    false
  end
end
