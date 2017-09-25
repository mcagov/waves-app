FactoryGirl.define do
  factory :carving_and_marking_reminder,
          class: "Notification::CarvingAndMarkingReminder" do
    recipient_name  Faker::Name.name
    recipient_email Faker::Internet.email
    notifiable      { build(:submission) }
  end
end
