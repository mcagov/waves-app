every 1.day, at: "4:30 am" do
  rake "waves:expire_referrals"
  rake "waves:process_reminders"
end
