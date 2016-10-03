FactoryGirl.define do
  factory :client_session do
    external_session_key  "MY_KEY"
    access_code           "111111"
  end
end
