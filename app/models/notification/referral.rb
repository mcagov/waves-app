class Notification::Referral < Notification

  def due_by
    30.days.from_now
  end
end
