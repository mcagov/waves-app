every 1.day, at: "12:01 am" do
  rake "waves:unclaim_claimed_submissions"
end

every 1.day, at: "4:30 am" do
  rake "waves:expire_referrals"
  rake "waves:process_reminders"
end
