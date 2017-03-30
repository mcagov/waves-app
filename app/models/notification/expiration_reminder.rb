class Notification::ExpirationReminder < Notification
  def send_email
    raise WavesError::BatchNotificationsAreDisabled
  end
end
