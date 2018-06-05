class NotificationApproval
  class << self
    def run_delayed(user)
      # NotificationApproval.delay.approve_all!(user)
    end

    private

    def approve_all!(user)
      Notification.pending_approval.find_each do |notification|
        notification.approve!(user)
      end
    end
  end
end
