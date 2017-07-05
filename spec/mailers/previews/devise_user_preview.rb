class DeviseUserEmailTemplatesPreview < ActionMailer::Preview
  def reset_password_instructions
    DeviseUserMailer.reset_password_instructions(
      User.new(name: "Bob", email: "bob@example.com"), "TOKEN")
  end
end
