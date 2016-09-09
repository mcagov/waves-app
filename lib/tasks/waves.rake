namespace :waves do
  task expire_referrals: :environment do
    Submission.referred.referred_until_expired.each(&:unreferred!)
  end
end
