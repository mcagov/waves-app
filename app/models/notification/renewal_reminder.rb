class Notification::RenewalReminder < Notification
  def send_email
    raise WavesError::BatchNotificationsAreDisabled
  end
end
