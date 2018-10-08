FactoryBot.define do
  factory :safety_certificate_reminder,
          class: "Notification::SafetyCertificateReminder" do
    recipient_name  Faker::Name.name
    recipient_email Faker::Internet.email
    notifiable      { build(:registered_vessel) }
  end
end
