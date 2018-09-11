FactoryBot.define do
  factory :submission_agent, class: "Submission::Agent" do
    name "Annabel Agent"
    email "agent@example.com"
    phone_number "1-800-AGENT"
  end
end
