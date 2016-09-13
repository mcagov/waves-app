USERS = %w(alice bob charlie develop).freeze

USERS.each do |user|
  u = User.find_or_initialize_by(name: user.humanize)
  u.email = "#{user}@example.com"
  u.password = "password"
  u.save!
end
