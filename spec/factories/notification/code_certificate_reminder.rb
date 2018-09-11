FactoryBot.define do
  factory :code_certificate_reminder,
          class: "Notification::CodeCertificateReminder" do
    recipient_name  Faker::Name.name
    recipient_email Faker::Internet.email
    notifiable      { build(:registered_vessel) }
  end
end
