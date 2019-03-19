env :PATH, ENV["PATH"]
env :GEM_PATH, ENV["GEM_PATH"]
set :output, "log/cron.log"

every 1.day, at: "4:00 am" do
  rake "waves:unclaim_claimed_tasks"
  rake "waves:expire_referrals"
  rake "waves:process_reminders"
  rake "waves:close_terminated_vessels"
  rake "waves:assign_scrubbable_vessels"
  rake "waves:clean_up_sessions"
end
